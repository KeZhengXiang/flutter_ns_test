//file:common.dart

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ns_test/resources/text_config.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';
import 'package:flutter_ns_test/tool/toast_util.dart';
import 'dart:convert' as convert;
import 'package:url_launcher/url_launcher.dart';

///导航键
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

///测试图片  "http://via.placeholder.com/350x150"
String getUrlImage(double w, double h) {
  return "http://via.placeholder.com/${w.toInt()}x${h.toInt()}";
}

///测试图片2
String getUrlImage2() {
  return "https://p1.pstatp.com/large/tos-cn-p-0015/0a4c42c89fea4e2e90c072ea4b392e34_1590146886.jpg";
}

///------------------------------------------------------------------------------------------------

///统一加载动画
Widget get loadingWidget {
  // return CupertinoActivityIndicator();//菊花
  return CircularProgressIndicator(); //转圈圈
}

///默认黑色 false，为true文本和图标的颜色会是白色的，否则就是黑色的。
bool _useWhite = false;

bool get useWhite => _useWhite;

///设置状态栏透明
Future<void> setStatusBarColor() {
  if (!(Platform.isIOS || Platform.isAndroid)) {
    return Future.value(0);
  }
  logDebug("设置状态栏透明");
  return Future.value(null);
  // return FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
}

///设置状态栏前景亮度
///  * [useWhiteForeground] - 设置为true，文本和图标的颜色会是白色的，否则就是黑色的。
Future<void> setStatusBarConfig({required bool useWhiteForeground}) async {
  // if (_useWhite == useWhiteForeground) {
  //   return;
  // }
  if (!(Platform.isIOS || Platform.isAndroid)) {
    return Future.value(0);
  }

  _useWhite = useWhiteForeground;
  logDebug("设置状态栏前景亮度： ${useWhiteForeground ? "白色" : "黑色"}");
  return Future.value(null);
  // return FlutterStatusbarcolor.setStatusBarWhiteForeground(useWhiteForeground);
}

class CommonUtil {
  ///编码
  static String encodeComponent(String str) {
    return Uri.encodeComponent(str);
  }

  ///解码
  static String decodeComponent(String str) {
    return Uri.decodeComponent(str);
  }

  ///json编码
  static String jsonEnCodeStr(Map<String, dynamic> map) {
    return convert.jsonEncode(map);
  }

  ///json解码
  static Map<String, dynamic> jsonDecode(String source) {
    return convert.jsonDecode(source);
  }

  ///加载本地json
  static Future<String> loadLocalJson({required String path}) async {
    return rootBundle.loadString(path);
  }

  static void launchURL({required String url}) async {
    if (await canLaunch(url)) {
      // 判断当前手机是否安装某app. 能否正常跳转
      await launch(url);
    } else {
      logDebug('Could not launch $url');
    }
  }

  ///退出APP
  static void closeApp() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  ///大陆手机号码11位数，匹配格式：前三位固定格式+后8位任意数
  /// 此方法中前三位格式有：
  /// 13+任意数 * 15+除4的任意数 * 18+除1和4的任意数 * 17+除9的任意数 * 147
  static bool isChinaPhoneLegal(String phone) {
    RegExp exp =
        RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    bool matched = exp.hasMatch(phone);
    return matched;
  }

  static bool checkPhone(String str) {
    if (isChinaPhoneLegal(str)) {
      return true;
    } else {
      ToastUtil.showToast(msg: TextConfig.common0);
    }
    return false;
  }

  ///密文显示手机号
  static String phoneCipherText(String phoneNumber) {
//  return "12345678911".replaceRange(3,6, '****');
    return phoneNumber.replaceRange(3, 7, '*****');
  }

  ///复制到剪切板
  static Future<void> setClipboard(String str) {
    return Clipboard.setData(ClipboardData(text: str));
  }

  ///从剪切板读取文本
  static Future<String?> getClipboard() async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text;
  }

  ///获取文本大小
  static Size getTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  ///通用
  static TextEditingController getTextEditingController({String text = ""}) {
    return TextEditingController.fromValue(
      TextEditingValue(
        // 设置内容
        text: text,
        // 保持光标在最后
        selection: TextSelection.fromPosition(
          TextPosition(affinity: TextAffinity.downstream, offset: text.length),
        ),
      ),
    );
  }

  ///获取数据类型
  static String dataType(dynamic value) {
    String typeStr = "unknown";
    if (value is Map) {
      typeStr = 'map';
    } else if (value is String) {
      typeStr = 'String';
    } else if (value is int) {
      typeStr = 'int';
    } else if (value is double) {
      typeStr = 'double';
    }
    return typeStr;
  }
}
//
// //屏幕统适配
// extension SizeExtension on num {
//   double get dw => this.w;
//
//   double get dh => this.h;
//
//   double get dsp {
//     return this.sp;
//   }
// }
