// 公共类
import 'dart:async';
import 'dart:io';
import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ns_test/http/http_tool.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

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

  // 当前平台
  static String get curPlatform => Platform.operatingSystem;

  //App包信息
  static PackageInfo? packageInfo;

  // 事件插件
  static EventBus eventBus = EventBus();

  static final battery = Battery();

  ///*********************************************]

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    logDebug("======================flutter init begin======================");
    await getDeviceInfo();

    await getPackageInfo();

    //监听网络状态
    HttpTool.instance.connectivityListenInit();
    logDebug("======================flutter init end======================");

    // print(await battery.batteryLevel);
    // battery.onBatteryStateChanged.listen((BatteryState state) {
    //   // Do something with new state
    //   if (state == BatteryState.full) {
    //     log("电池充满");
    //   } else if (state == BatteryState.charging) {
    //     log("电池正在充电");
    //   } else if (state == BatteryState.discharging) {
    //     log("电池正在放电");
    //   } else {
    //     //unknown
    //     log("电池状态未知");
    //   }
    // });
  }

  //初始化界面数据
  static void uiInit(BuildContext context) async {
    logDebug("======================flutter uiInit begin======================");

    logDebug("是否为release版: $isRelease");

    logDebug("当前平台: $curPlatform");

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
    logDebug("屏幕参数：\n "
        "设备像素密度；${ScreenUtil().pixelRatio} \n "
        "设备宽度；$screenWidth \n "
        "设备高度；$screenHeight \n "
        "状态栏高度；$statusBarHeight \n "
        "底部安全区距离；$bottomBarHeight");
    logDebug("[AppBar]工具栏组件的高度: kToolbarHeight = $kToolbarHeight");
    logDebug("底部导航栏的高度: kBottomNavigationBarHeight = $kBottomNavigationBarHeight");

    // 强制竖屏
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    logDebug("======================flutter uiInit end======================");
  }

  ///获取APP包信息
  static Future<PackageInfo?> getPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    logDebug("--------包信息：\n"
        "APP名称: ${packageInfo?.appName ?? "unknown"}\n"
        "包名: ${packageInfo?.packageName ?? "unknown"}\n"
        "版本名: ${packageInfo?.version ?? "unknown"}\n"
        "版本号: ${packageInfo?.buildNumber ?? "unknown"}");
    String buildSignature = packageInfo?.buildSignature ?? "";
    if (buildSignature.isNotEmpty) {
      logDebug("Android 签名：$buildSignature");
    }
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
        logDebug("IOS设备: identifierForVendor = ${iosDeviceInfo?.toMap()}");
        logDebug("IOS设备：");
        logV(androidDeviceInfo?.toMap());
      } else if (Platform.isAndroid) {
        androidDeviceInfo = await deviceInfo.androidInfo;
        deviceId = androidDeviceInfo?.androidId ?? "";
        // log("Android设备: androidId = ${androidDeviceInfo?.toMap()}}");
        logDebug("Android设备信息：");
        logV(androidDeviceInfo?.toMap());
      } else {
        logDebug("设备信息：其他设备");
      }
    } catch (e) {
      print("获取设备信息报错：e:$e");
    }
  }
}
