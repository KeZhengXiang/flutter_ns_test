import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ns_test/router/routes.dart';

// 1、清除路由堆栈跳转：即跳转后的页面作为根页面（没有返回按钮），这种适合闪屏页跳到首页。代码如下：
//  RouterManager.router.navigateTo(context, RouterManager.homePath, clearStack: true);
// 2、普通跳转：无参数直接跳转，代码如下：
//  RouterManager.router.navigateTo(context, RouterManager.loginPath);
// 3、带参数跳转：路由路径携带参数，和普通跳转类似，只是拼接了路径参数和 query 参数：
//  RouterManager.router.navigateTo(context, '${RouterManager.dynamicPath}/$id?event=a&event=b')

//clearStack 设置当前路由为根路由
//replace 取代当前路由

///跳转调用
class RouterUtil {
  //过度动画类型
  static const TransitionType _transitionType = TransitionType.inFromRight;

  static Future<dynamic> goHomePage(BuildContext context) {
    return navigateTo(context, Routes.homePage,
        params: {"title": "HomePage"}, transition: _transitionType, clearStack: true);
  }

  static Future<dynamic> goHouseToolPage(BuildContext context) {
    return navigateTo(context, Routes.houseToolPage, transition: _transitionType);
  }

  static Future<dynamic> goBlocTestPage(BuildContext context) {
    return navigateTo(context, Routes.blocTestPage, transition: _transitionType);
  }

  static Future<dynamic> goSensingBannerPage(BuildContext context) {
    return navigateTo(context, Routes.sensingBannerPage, transition: _transitionType);
  }

  static Future<dynamic> goFullScreenSensingPage(BuildContext context) {
    return navigateTo(context, Routes.fullScreenSensingPage, transition: _transitionType);
  }

  ///自定义的参数跳转
  ///对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配
  static Future navigateTo(BuildContext context, String path,
      {Map<String, dynamic>? params,
      bool replace = false,
      bool clearStack = false,
      bool rootNavigator = false,
      TransitionType transition = _transitionType}) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
      print('【$path】传递的参数：$query');
      path = path + query;
    }
    return Routes.router.navigateTo(context, path,
        transition: transition,
        replace: replace,
        clearStack: clearStack,
        rootNavigator: rootNavigator);
  }
}
