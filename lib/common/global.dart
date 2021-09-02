// 公共类
import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';

class Global {
  static const double defaultWidth = 375.0;
  static const double defaultHeight = 667.0;

  /// 当前设备宽度 dp
  static late double screenWidth;

  /// 当前设备高度 dp
  static late double screenHeight;

  /// 状态栏高度 dp 刘海屏会更高
  static late double statusBarHeight;

  /// 底部安全区距离 dp
  static late double bottomBarHeight;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static bool get isIOS => Platform.isIOS;

  static bool get isAndroid => Platform.isAndroid;

  // 当前平台
  static TargetPlatform? targetPlatform;

  //App包信息
  static PackageInfo? packageInfo;

  // 事件插件
  static EventBus eventBus = EventBus();

  // 网络缓存对象
  // static NetCache netCache = NetCache();

  ///*********************************************]

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    log("======================flutter init begin======================");
    await getDeviceInfo();

    await getPackageInfo();
    log("======================flutter init end======================");
  }

  //初始化界面数据
  static void uiInit(BuildContext context) async {
    log("======================flutter uiInit begin======================");

    log("是否为release版: $isRelease");
    if (Platform.isIOS) {
      targetPlatform = TargetPlatform.iOS;
    } else {
      targetPlatform = TargetPlatform.android;
    }
    log("当前平台: ${targetPlatform ?? "unknown"}");

    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(Global.defaultWidth, Global.defaultHeight),
        orientation: Orientation.portrait);

    screenWidth = ScreenUtil().screenWidth;
    screenHeight = ScreenUtil().screenHeight;
    statusBarHeight = ScreenUtil().statusBarHeight;
    bottomBarHeight = ScreenUtil().bottomBarHeight;
    log("\n "
        "设备像素密度；${ScreenUtil().pixelRatio} \n "
        "设备宽度；$screenWidth \n "
        "设备高度；$screenHeight \n "
        "状态栏高度；$statusBarHeight \n "
        "底部安全区距离；$bottomBarHeight");
    log("[AppBar]工具栏组件的高度: kToolbarHeight = $kToolbarHeight");
    log("底部导航栏的高度: kBottomNavigationBarHeight = $kBottomNavigationBarHeight");

    // 强制竖屏
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    log("======================flutter uiInit end======================");
  }

  ///获取APP包信息
  static Future<PackageInfo?> getPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    log("--------包信息：\n "
        "APP名称: ${packageInfo?.appName ?? "unknown"}\n"
        "包名: ${packageInfo?.packageName ?? "unknown"}\n"
        "版本名: ${packageInfo?.version ?? "unknown"}\n"
        "版本号: ${packageInfo?.buildNumber ?? "unknown"}");
    return packageInfo;
  }

  ///****************************
  static IosDeviceInfo? iosDeviceInfo;
  static AndroidDeviceInfo? androidDeviceInfo;
  static String deviceId = "";

  ///获取设备信息
  static Future<void> getDeviceInfo() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        iosDeviceInfo = await deviceInfo.iosInfo;
        deviceId = iosDeviceInfo?.identifierForVendor ?? "";
        log("IOS设备: identifierForVendor = $deviceId");
      } else if (Platform.isAndroid) {
        androidDeviceInfo = await deviceInfo.androidInfo;
        deviceId = androidDeviceInfo?.androidId ?? "";
        log("Android设备: androidId = $deviceId");
      }
    } catch (e) {
      print("获取设备信息报错：e:$e");
    }
  }
}
