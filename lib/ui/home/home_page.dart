import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_ns_test/component/d_button.dart';
import 'package:flutter_ns_test/component/my_will_pop_scope.dart';
import 'package:flutter_ns_test/http/api.dart';
import 'package:flutter_ns_test/http/http_tool.dart';
import 'package:flutter_ns_test/router/router_util.dart';
import 'package:flutter_ns_test/extension/size_extension.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';
import 'package:flutter_ns_test/tool/toast_util.dart';

import 'widgets_binding_manager.dart';

//首页
class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  initData() {
    WidgetsBinding.instance?.addObserver(WidgetsBindingManager.instance);
  }

  @override
  void initState() {
    // dio.interceptors.add(HttpFormatter());
    // LanguageChangeJson.change();
    Future.delayed(Duration(milliseconds: 1000)).then((value) => initData());
    super.initState();
  }

  @override
  void dispose() {
    HttpTool.instance.connectivityListenCancel();
    WidgetsBinding.instance?.removeObserver(WidgetsBindingManager.instance);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyWillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: btnChildren,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            ToastUtil.showText(msg: "随便点点");

            // logI(Dio().options.headers);
            // API.appVersion();

          },
        ),
      ),
    );
  }

  List<Widget> get btnChildren {
    return <Widget>[
      //
      DButton(
        padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5.dw),
        color: Theme.of(context).accentColor,
        child: Text(
          "初识 flutter_bloc",
          style: TextStyle(fontSize: 16.dsp, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        onPressed: () {
          RouterUtil.goBlocTestPage(context);
        },
      ),

      //
      DButton(
        padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5.dw),
        color: Theme.of(context).accentColor,
        child: Text(
          "初识 provider",
          style: TextStyle(fontSize: 16.dsp, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        onPressed: () {
          RouterUtil.goProviderTestPage(context);
        },
      ),

      //
      DButton(
        padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5.dw),
        color: Theme.of(context).accentColor,
        child: Text(
          "私人计算器",
          style: TextStyle(fontSize: 16.dsp, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        onPressed: () {
          RouterUtil.goHouseToolPage(context);
        },
      ),

      //
      DButton(
        padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5.dw),
        color: Theme.of(context).accentColor,
        child: Text(
          "SensingBannerPage",
          style: TextStyle(fontSize: 16.dsp, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        onPressed: () {
          RouterUtil.goSensingBannerPage(context);
        },
      ),

      //
      DButton(
        padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5.dw),
        color: Theme.of(context).accentColor,
        child: Text(
          "FullScreenSensingPage",
          style: TextStyle(fontSize: 16.dsp, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        onPressed: () {
          RouterUtil.goFullScreenSensingPage(context);
        },
      ),
    ];
  }
}
