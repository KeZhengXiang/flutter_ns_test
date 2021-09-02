import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ns_test/common/global.dart';
import 'package:flutter_ns_test/component/btn_text_round_countdown.dart';
import 'package:flutter_ns_test/component/my_will_pop_scope.dart';
import 'package:flutter_ns_test/resources/image_path.dart';
import 'package:flutter_ns_test/extension/size_extension.dart';
import 'package:flutter_ns_test/router/router_util.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';

//启动页
class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  void goHome() {}

  void refreshUI() {
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    Global.init().then((value) => refreshUI());
    // Future.delayed(Duration(milliseconds: 10)).then((value) => Global.uiInit(context));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Global.uiInit(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MyWillPopScope(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              //启动图
              Image.asset(ImagePath.background, fit: BoxFit.cover),

              // 倒计时
              Positioned(
                top: Global.statusBarHeight + 10,
                right: 15,
                child: KBtnTextRoundCountdown(
                  "进入",
                  3,
                  width: 90.dw,
                  height: 35.dw,
                  radius: 35.dw / 2,
                  callback: (CTBCallbackType type) {
                    if (type == CTBCallbackType.complete) {
                      log("倒计时间到，自动跳转首页");
                      RouterUtil.goHomePage(context);
                    } else if (type == CTBCallbackType.click) {
                      log("被点击，执跳转首页");
                      RouterUtil.goHomePage(context);
                    }
                  },
                ),
              ),

              Positioned(
                bottom: Global.bottomBarHeight + 20.dw,
                right: 20.dw,
                child: Text(
                  (Global.packageInfo?.version ?? '0.0.0') +
                      " - " +
                      (Global.packageInfo?.buildNumber ?? 0).toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 11.dsp,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
