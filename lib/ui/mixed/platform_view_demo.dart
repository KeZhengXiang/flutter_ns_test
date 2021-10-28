import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ns_test/component/button.dart';
import 'package:flutter_ns_test/tool/toast_util.dart';

class PlatformViewDemo extends StatefulWidget {
  @override
  _PlatformViewDemoState createState() => _PlatformViewDemoState();
}

class _PlatformViewDemoState extends State<PlatformViewDemo> {
  static const platform = const MethodChannel('com.flutter.guide.MyFlutterView');

  @override
  Widget build(BuildContext context) {
    Widget platformView() {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return AndroidView(
          viewType: 'plugins.flutter.io/custom_platform_view',
          creationParams: {'text': 'Flutter传给AndroidTextView的参数'},
          creationParamsCodec: StandardMessageCodec(),
        );
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        return UiKitView(
          viewType: 'plugins.flutter.io/custom_platform_view',
          creationParams: {'text': 'Flutter传给IOSTextView的参数'},
          creationParamsCodec: StandardMessageCodec(),
        );
      }
      return Container(
        child: Center(
          child: Text("空视图"),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        DButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text('传递参数给原生View'),
          ),
          onPressed: () {
            if (Platform.isIOS)
              platform.invokeMethod('setText', {'name': 'laomeng', 'age': 18});
            else
              ToastUtil.showToast(msg: "Android 无通讯");
          },
        ),
        // platformView(),
        Expanded(
          child: platformView(),
        ),//104.79
      ],
    );
  }
}
