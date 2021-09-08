import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';

///APP状态监听
class WidgetsBindingManager with WidgetsBindingObserver {
  static final WidgetsBindingManager _instance = WidgetsBindingManager._internal();

  static WidgetsBindingManager get instance => _instance;

  factory WidgetsBindingManager() {
    return _instance;
  }

  WidgetsBindingManager._internal(); // 不需要初始化

  ///******************************************************
  ///******************************************************
  //
  void logBd(Object obj) {
    log("【APP状态监听】:$obj");
  }

  // 当前系统改变了一些访问性活动的回调
  void didChangeAccessibilityFeatures() {
    logBd("当前系统改变了一些访问性活动的回调");
  }

  /// App 生命周期改变回调
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var statusStr = "";
    switch (state) {
      case AppLifecycleState.inactive: // 非活动状态
        statusStr = "非活动状态";
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        statusStr = "应用程序进入前台";
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        statusStr = "应用程序进入后台";
        break;
      case AppLifecycleState.detached:
        statusStr = "视图托管在Flutter引擎状态";
        //    该应用程序仍托管在Flutter引擎上，但与任何主机视图均分离。
        //    当应用程序处于此状态时，引擎将在没有视图的情况下运行。
        //引擎首次初始化时，或者在由于导航器弹出而销毁视图之后，可能正在附加视图。
        break;
    }
    logBd("App 生命周期改变回调" + state.toString() + statusStr);
  }

  // 本地化语言改变回调
  void didChangeLocales(List<Locale>? locale) {
    logBd("本地化语言改变回调");
  }

  // 系统窗口相关改变回调，例如旋转
  void didChangeMetrics() {
    logBd("系统窗口相关改变回调，例如旋转");
  }

  // 系统亮度改变回调
  void didChangePlatformBrightness() {
    logBd("系统亮度改变回调");
  }

  // 文本缩放系数改变回调
  void didChangeTextScaleFactor() {
    logBd("文本缩放系数改变回调：textScaleFactor = ${WidgetsBinding.instance?.window.textScaleFactor ?? 0.0}");
  }

  // 内存不足警告回调【低内存回调】
  void didHaveMemoryPressure() {
    logBd("内存不足警告回调【低内存回调】");
  }

  //当前未使用
  // // 页面 pop
  // Future<bool> didPopRoute() {
  //   logBd("页面 pop");
  //   return Future<bool>.value(false);
  // }
  //
  // // 页面 push
  // Future<bool> didPushRoute(String route) {
  //   logBd("页面 push, route【$route】");
  //   return Future<bool>.value(false);
  // }
}
