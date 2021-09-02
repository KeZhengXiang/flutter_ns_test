import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_ns_test/component/d_button.dart';
import 'package:flutter_ns_test/component/my_will_pop_scope.dart';
import 'package:flutter_ns_test/router/router_util.dart';
import 'package:flutter_ns_test/extension/size_extension.dart';
import 'package:flutter_ns_test/tool/toast_util.dart';

//首页
class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    // setState(() {
    //   _counter++;
    // });

    // Navigator.of(context).push(
    //   MaterialPageRoute<void>(
    //     builder: (BuildContext context) {
    //       return BlocProvider(create: (_) => CounterCubit(), child: BlocTestPage());
    //     },
    //   ),
    // );

    RouterUtil.goHouseToolPage(context);
  }

  @override
  void initState() {
    // LanguageChangeJson.change();
    super.initState();
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
          onPressed: () {
            ToastUtil.showText(msg: "随便点点");
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
