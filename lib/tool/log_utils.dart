//日志工具

import 'package:flutter_ns_test/common/global.dart';
import 'package:logger/logger.dart';

var logger = Logger();

void log(Object object) {
  if (!Global.isRelease) {
    print(object);
  }
}

void logV(dynamic message) {
  logger.v(message);
}

void logD(dynamic message) {
  logger.d(message);
}

void logI(dynamic message) {
  logger.i(message);
}

void logW(dynamic message) {
  logger.w(message);
}

void logE(dynamic message) {
  logger.e(message);
}

void logWtf(dynamic message) {
  logger.wtf(message);
}

///预览级别
void logPreviewLevel() {
  logger.v("Verbose 详细的 log");

  logger.d("Debug log");

  logger.i("Info log");

  logger.w("Warning 警告⚠️ log");

  logger.e("Error 错误 log");

  logger.wtf("What a terrible failure log  多么可怕的失败日志");
}

///查看当前栈
void logCurStack() {
  print(StackTrace.current.toString());
}
