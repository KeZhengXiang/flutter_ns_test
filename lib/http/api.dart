import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_ns_test/model/version_model.dart';
import 'http_tool.dart';

class API {
  ///====================================================================

  static Future<VersionModel?> appVersion() async {
    // final response = await dio.get('https://jsonplaceholder.typicode.com/photos');
    final response = await HttpTool.instance.request(
        isGet: false,
        url: 'https://www.weaves.cn/airdrop/rest/api/appversion',
        isIntactUrl: true,
        isCache: true);
    if (response == null) {
      return null;
    }
    //解析
    return compute(isoLPFetchPhotos, response.data as Map<String, dynamic>);
  }

  ///隔离解析
  static VersionModel isoLPFetchPhotos(Map<String, dynamic> json) {
    //解析
    DateTime dateTime = DateTime.now();
    VersionModel model = VersionModel().fromJson(json);
    print("解析时间（ms）：${DateTime.now().millisecondsSinceEpoch - dateTime.millisecondsSinceEpoch}");
    return model;
  }

  //------------------------性感的分割线----------------------------
  ///测试隔离解析
  static Future<int> test() async {
    // final response = await dio.get('https://jsonplaceholder.typicode.com/photos');
    final response = await HttpTool.instance.request(
        isGet: false, url: 'https://www.weaves.cn/airdrop/rest/api/appversion', isIntactUrl: true);
    if (response == null) {
      return 0;
    }
    //解析
    return compute(isoLPTest, response.data as Map<String, dynamic>);
  }

  ///隔离解析
  static int isoLPTest(Map<String, dynamic> json) {
    DateTime dateTime = DateTime.now();
    //解析
    int count = 0;
    for (int i = 0; i < 1000000000; ++i) {
      count++;
    }
    print("解析时间（ms）：${DateTime.now().millisecondsSinceEpoch - dateTime.millisecondsSinceEpoch}");
    return count;
  }
}
