import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter_ns_test/http/http_tool.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';

//额外参数配置
class ExtraKey {
  static const String cache = "cache"; //标记，有则缓存数据单元
  static const String refresh = "refresh"; //标记，存在则拉取最新数据，不使用缓存【覆盖之前缓存记录】
}

//网络数据缓存对象（网络数据单元）
class CacheObject {
  CacheObject(this.response) : timeStamp = DateTime.now().millisecondsSinceEpoch;

  final Response response; //完整请求数据
  int timeStamp; //缓存时间戳

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

//网络数据缓存插件（拦截器）
class NetCacheInterceptors extends Interceptor {
  // 为确保迭代器顺序和对象插入时间一致顺序一致，我们使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!HttpTool.instance.cacheConfig.enable) {
      log("拦截器-CacheObject-onRequest: 已禁用缓存");
      return handler.next(options);
    }
    log("NetCacheInterceptors  9981 ${options.extra}");
    if (options.extra.containsKey(ExtraKey.cache)) {
      String key = options.uri.toString();
      //是否刷新
      if (options.extra.containsKey(ExtraKey.refresh)) {
        log("拦截器-CacheObject-onRequest: refresh = true, list = false");
        //则只删除uri相同的缓存
        cache.remove(key);
      } else {
        // if (options.method.toLowerCase() == 'get') {
          if (cache.containsKey(key)) {
            var ob = cache[key]!;
            //若缓存未过期，则返回缓存内容
            if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
                HttpTool.instance.cacheConfig.maxAge) {
              log("拦截器-CacheObject-onRequest: 缓存未过期，返回缓存数据");
              return handler.resolve(cache[key]!.response);
            } else {
              //若已过期则删除缓存，继续向服务器请求
              log("拦截器-CacheObject-onRequest: 缓存过期，不拦截");
              cache.remove(key);
            }
          }
        // } else
        //   return handler.next(options);
      }
      return handler.next(options);
    } else
      return handler.next(options);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data == null) {
      return;
    }
    // 如果启用缓存，将返回结果保存到缓存
    if (HttpTool.instance.cacheConfig.enable) {
      _saveCache(response);
    }
  }

  _saveCache(Response object) {
    RequestOptions options = object.requestOptions;
    if (options.extra.containsKey(ExtraKey.cache) /* && options.method.toLowerCase() == "get"*/) {
      log("拦截器-CacheObject-onResponse: 开始缓存");
      // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (cache.length >= HttpTool.instance.cacheConfig.maxCount) {
        cache.remove(cache.keys.first);
        log("拦截器-CacheObject-onResponse: 开始缓存，超量，移除首条缓存");
      }
      String key = options.uri.toString();
      cache[key] = CacheObject(object);
    }
  }
}
