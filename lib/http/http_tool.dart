import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter_ns_test/common/global.dart';
import 'package:flutter_ns_test/http/net_cache_interceptors.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';
import 'package:flutter_ns_test/tool/toast_util.dart';
import 'api_url.dart';
import 'code.dart';
import 'http_model/cache_config.dart';
import 'response_interceptors.dart';

///dio文档 使用：https://github.com/flutterchina/dio/blob/master/README-ZH.md#示例
class HttpTool {
  static bool isLog = false;
  static HttpTool? _instance;

  static HttpTool get instance {
    if (_instance == null) {
      _instance = HttpTool._internal();
    }
    return _instance!;
  }

  factory HttpTool() {
    return instance;
  }

  HttpTool._internal() {
    init();
  }

  //---------------------------------性感的分割线---------------------------------------

  CacheConfig cacheConfig = CacheConfig(enable: true);
  late Dio _dio;

  Dio get dio => _dio;

  final String baseUrl = ApiUrl.baseUrl;
  final String urlVersion = "/v1";
  final int _connectTimeout = 10 * 1000;
  final int _receiveTimeout = 150 * 1000;

  final CancelToken cancelToken = CancelToken();

  ///取消所有请求
  void cancelNet() {
    logDebug("取消所有请求");
    cancelToken.cancel("cancelled");
  }

  ///网络等初始化设置
  void init() {
    print("http init ");
    _dio = Dio();

    /// 全局属性：请求前缀、连接超时时间、响应超时时间
    final options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      contentType: Headers.jsonContentType,
      // 将响应数据转换为使用UTF8编码的字符串。默认值为[ResponseType.JSON]。
      // responseType: ResponseType.plain,
    );

    ///配置 headers
    // Map<String, dynamic> initHeaders = {
    //   //默认项
    //   HttpHeaders.contentTypeHeader: Headers.jsonContentType,
    // };
    //版本
    options.headers["appVersionCode"] = Global.packageInfo?.buildNumber ?? "";
    options.headers["appVersionName"] = Global.packageInfo?.version ?? "";

    //当前平台 【"linux"、"macos"、"windows"、"android"、"ios"、"fuchsia"】
    options.headers["platform"] = Platform.operatingSystem;

    //android ios 设备ID
    String deviceID = "";
    if (Platform.isIOS) {
      deviceID = Global.iosDeviceInfo?.identifierForVendor ?? "";
    } else if (Platform.isAndroid) {
      deviceID = Global.androidDeviceInfo?.androidId ?? "";
    }
    options.headers["deviceID"] = deviceID;

    //填入数据
    _dio.options = options;

    // 添加缓存插件
    // _dio.interceptors.add(Global.netCache);

    // dio控制台日志插件
    dio.interceptors.add(HttpFormatter());
    dio.interceptors.add(ResponseInterceptors());
    dio.interceptors.add(NetCacheInterceptors());

    //代理相关
    // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) {
    //     return Platform.isAndroid;
    //   };
    //   client.findProxy = (uri) {
    //     return "PROXY 192.168.31.167:8899";
    //   };
    // };
  }

  /// 请求
  /// * [isGet] - 为true get,否则为 post
  /// * [url] - 请求url
  /// * [param] - 请求参数
  /// * [needVersion] - url是否需要加版本号【依照具体业务需求】
  /// * [isIntactUrl] - 当前url是否是完整的url
  /// * [needToken] - 是否需要token
  /// * [isCache] - 是否缓存数据【已添加缓存拦截器才有效】
  /// * [cToken] - 取消请求句柄
  Future<Response?> request({
    required bool isGet,
    required String url,
    Map<String, dynamic>? param,
    bool needVersion = false, //url是否需要加版本号
    bool isIntactUrl = false, //是否是完整的url
    bool needToken = false, //是否需要token
    bool isCache = false, //是否缓存数据
    CancelToken? cToken,
  }) async {
    ///检测网络
    if (!(await checkConnectivity())) {
      return null;
    }

    ///完整的url后缀
    String intactUrl = isIntactUrl ? url : configurationUrl(url, needVersion);

    ///************** header begin **************
    ///request token
    if (needToken) {
      // if (client == null || client.token == null || client.token.isEmpty) {
      //   // Global.pupLoginWidget(tip: "认证信息失效,请重新登录", isMandatory: true);
      //   // return null;
      // } else {
      //   _dio.options.headers["token"] = client.token;
      // }
    } else {
      if (_dio.options.headers.containsKey("token")) {
        _dio.options.headers.remove("token");
      }
    }

    ///************** header end **************

    ///
    Options? _options;
    if (isCache) {
      _options = Options(extra: {ExtraKey.cache: true});
      print("99234298 ${_options.extra}");
      dio.options.extra[ExtraKey.cache] = true;
      print("992342982 ${dio.options.extra}");
    }

    try {
      if (isLog) {
        logDebug("【DIO】headers = ${dio.options.headers} \n"
            "【DIO】isGet   = $isGet, url = $intactUrl, \n"
            "【DIO】param   = $param");
      }
      Response response;
      if (isGet) {
        response = await _dio.get(intactUrl,
            options: _options,
            queryParameters: param,
            cancelToken: cToken ?? cancelToken,
            onReceiveProgress: progressCallback);
      } else {
        response = await _dio.post(intactUrl,
            options: _options,
            queryParameters: param,
            cancelToken: cToken ?? cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: progressCallback);
      }
      // if (isLog) {
      //   log("【DIO】url: $intactUrl");
      //   log("【DIO】headers = ${dio.options.headers} \n"
      //       "【DIO】param   = $param");
      //   log(response);
      // }

      if (response.data == null) {
        return null;
      } else {
        final Map<String, dynamic> jsonMap = response.data ?? {};
        if (jsonMap.containsKey("code") == false) {
          return response;
        } else {
          final int code = jsonMap["code"];
          if (code == HttpCode.SUCCESS) {
            return response;
          } else {
            //提示信息
            if (jsonMap.containsKey("message")) {
              final String msg = jsonMap["message"] ?? "";
              if (msg.isNotEmpty) {
                ToastUtil.showToast(msg: msg);
              }
            }
            responseCode(code);
            return null;
          }
        }
      }
    } on DioError catch (e) {
      dioError(e);
      return null;
    }
  }

  ///上传数据
  void onSendProgress(int count, int total) {
    logDebug("onSendProgress: total = $total, count = $count");
  }

  ///下载数据
  void progressCallback(int count, int total) {
    logDebug("progressCallback: total = $total, count = $count");
  }

  ///响应码处理
  void responseCode(int code) {}

  void dioError(DioError e) {
    logDebug("-------------网络请求错误：DioError: begin:--------------------");
    if (e.type == DioErrorType.cancel) {
      logDebug("类型：请求被取消");
    } else if (e.type == DioErrorType.response) {
      ToastUtil.showToast(msg: "服务器未响应，请稍后...");
    } else if (e.type == DioErrorType.connectTimeout) {
      logDebug("类型：超时打开时");
      // ToastUtil.showToast(msg: "请求超时");
    } else if (e.type == DioErrorType.sendTimeout) {
      logDebug("类型：请求超时");
      // ToastUtil.showToast(msg: "请求超时");
    } else if (e.type == DioErrorType.receiveTimeout) {
      logDebug("类型：接收超时");
    } else if (e.type == DioErrorType.other) {
      logDebug("类型：其他 other");
    }
    logDebug("http错误 path：${e.response?.requestOptions.path}");
    logDebug("http错误 queryParameters：${e.response?.requestOptions.queryParameters}");
    logDebug("-------------网络请求错误：DioError: end:--------------------");
  }

  ///配置url后缀
  String configurationUrl(String url, bool needVersion) {
    ///完整的url后缀
    String intactUrl = "";
    if (needVersion) {
      intactUrl = "$baseUrl$urlVersion$url";
    } else {
      intactUrl = "$baseUrl$url";
    }
    return intactUrl;
  }

  ///**********  检测网络变化  begin **********

  Connectivity? _connectivity;
  ConnectivityResult? _connectivityResult;

  ///主动检测
  Future<bool> checkConnectivity() async {
    // if (_connectivity == null) {
    //   _connectivity = Connectivity();
    // }
    // var connectivityResult = await (_connectivity!.checkConnectivity());

    if (_connectivityResult == ConnectivityResult.mobile) {
      // 移动网络
    } else if (_connectivityResult == ConnectivityResult.wifi) {
      // wifi
    } else if (_connectivityResult == ConnectivityResult.ethernet) {
      // 连接到以太网网络
    } else {
      ToastUtil.showToast(msg: "网络已断开,请检查网络");
      ToastUtil.closeAllLoading();
      return false;
    }
    return true;
  }

  ///订阅监听流
  StreamSubscription? subscription;

  void connectivityListenInit() {
    if (subscription != null) {
      return;
    }
    if (_connectivity == null) {
      _connectivity = Connectivity();
    }
    subscription = _connectivity!.onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      this._connectivityResult = result;
      logI("网络连接变化：$result");
      if (result == ConnectivityResult.mobile) {
        // 移动网络
      } else if (result == ConnectivityResult.wifi) {
        // wifi
      } else if (result == ConnectivityResult.ethernet) {
        // 连接到以太网网络
      } else {
        ToastUtil.showToast(msg: "网络已断开,请检查网络");
        ToastUtil.closeAllLoading();
      }
    });
  }

  void connectivityListenCancel() {
    subscription?.cancel();
  }

  ///**********  检测网络变化  end **********
}
