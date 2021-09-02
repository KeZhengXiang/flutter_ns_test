import 'package:flutter/material.dart';
import 'package:flutter_ns_test/common/common.dart';
import 'package:flutter_ns_test/tool/toast_util.dart';

///回退键拦截
class MyWillPopScope extends StatefulWidget {
  MyWillPopScope({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<MyWillPopScope> createState() => _MyWillPopScopeState();
}

class _MyWillPopScopeState extends State<MyWillPopScope> {
  DateTime? lastPopTime;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 点击返回键的操作
        if (lastPopTime == null || DateTime.now().difference(lastPopTime!) > Duration(seconds: 2)) {
          lastPopTime = DateTime.now();
          ToastUtil.showText(msg: "再按一次退出");
          return false;
        } else {
          lastPopTime = DateTime.now();
          // 退出app
          CommonUtil.closeApp();
          return true;
        }
      },
      child: widget.child,
    );
  }
}
