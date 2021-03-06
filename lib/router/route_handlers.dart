import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ns_test/tool/permission_util.dart';
import 'package:flutter_ns_test/ui/3d_page/full_screen_sensing_page.dart';
import 'package:flutter_ns_test/ui/3d_page/sensing_banner_page.dart';
import 'package:flutter_ns_test/ui/empty_page.dart';
import 'package:flutter_ns_test/ui/home/home_page.dart';
import 'package:flutter_ns_test/ui/start_page.dart';
import 'package:flutter_ns_test/ui/test/bloc/bloc_test_page.dart';
import 'package:flutter_ns_test/ui/test/get/x_home.dart';
import 'package:flutter_ns_test/ui/test/house_tool_page.dart';
import 'package:flutter_ns_test/ui/test/provider/provider_test_model.dart';
import 'package:flutter_ns_test/ui/test/provider/provider_test_page.dart';
import 'package:flutter_ns_test/ui/video/short_video/short_video_page.dart';
import 'package:flutter_ns_test/ui/video/video_list_page.dart';
import 'package:flutter_ns_test/ui/video/long_video/video_page.dart';
import 'package:provider/provider.dart';

//空页面
var emptyHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return EmptyPage();
});

//根页面
var rootHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return StartPage();
  // return GetXHomePage();
});

//首页
var homeHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String title = params["title"]?.first ?? "";
  // return PermissionHandlerWidget();
  return HomePage(title: title);
});

var blocTestHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return BlocProvider(create: (_) => CounterCubit(), child: BlocTestPage());
});

var houseToolHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  // return CupertinoPageRoute(builder: (BuildContext context) {
  //   return HouseToolPage();
  // });
  //     Navigator.of(context!).push(CupertinoPageRoute(builder: (BuildContext context){
  //       return HouseToolPage();
  //     }));
  //     Navigator.of(context!).popUntil((route) => false)
  return HouseToolPage();
});

var providerTestHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  // return ProviderTestPage();
  return MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ProviderTestModel())],
    child: ProviderTestPage(),
  );
});

var sensingBannerHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SensingBannerPage();
});
var fullScreenSensingHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return FullScreenSensingPage();
});

var videoPageHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return VideoPage();
});

var videoListPageHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return VideoListPage();
});
var shortVideoPageHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return ShortVideoPage();
});

var permissionHandlerWidgetHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return PermissionHandlerWidget();
});
