import 'package:bot_toast/bot_toast.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ns_test/ui/start_page.dart';
import 'package:get/get.dart';
import 'common/common.dart';
import 'router/routes.dart';
import 'ui/test/get/x_home.dart';
import 'ui/test/language_change_json.dart';
import 'dart:ui' as ui;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  MyAppState() {
    //初始化配置路由
    Routes.configureRoutes(FluroRouter());
  }

  @override
  void initState() {
    // LanguageChangeJson.change2();
    setStatusBarColor();
    setStatusBarConfig(useWhiteForeground: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // runApp(GetMaterialApp(home: Home()));
    return GetMaterialApp(
      translations: Messages(), // 你的翻译
      locale: ui.window.locale,//系统语言
      // locale: Locale('zh', 'CN'), // 将会按照此处指定的语言翻译
      fallbackLocale: Locale('en', 'US'), // 添加一个回调语言选项，以备上面指定的语言翻译不存在


      // //调试显示检查模式横幅（右上角DEBUG标签）
      // debugShowCheckedModeBanner: true,
      // //调试显示材质网格
      // debugShowMaterialGrid: true,
      // //显示语义调试器
      // showSemanticsDebugger: true,
      // //棋盘格光栅缓存图像
      // checkerboardRasterCacheImages: true,
      // //棋盘格层
      // checkerboardOffscreenLayers: true,
      // //显示性能叠加
      // showPerformanceOverlay: true,

      navigatorKey: navigatorKey,
      // router: RouterUtil.appRouter,
      builder: BotToastInit(),
      //1.调用BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      //2.注册路由观察者
      // home: StartPage(),
      // home: HomePage(title: "home"),
      // home: HouseToolPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        primaryColor: Colors.blue,
        primarySwatch: Colors.blue,
        backgroundColor: Colors.black,
      ),
      onGenerateRoute: Routes.router.generator,
    );
  }
}
