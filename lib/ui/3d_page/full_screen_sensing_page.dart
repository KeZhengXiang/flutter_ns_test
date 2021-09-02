import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ns_test/common/common.dart';

import 'flutter_interactional_widget.dart';
import 'package:flutter_ns_test/extension/size_extension.dart';

class FullScreenSensingPage extends StatefulWidget {
  const FullScreenSensingPage({Key? key}) : super(key: key);

  @override
  _FullScreenSensingPageState createState() => _FullScreenSensingPageState();
}

class _FullScreenSensingPageState extends State<FullScreenSensingPage> {
  bool useWhiteForeground = useWhite;

  @override
  void initState() {
    // TODO: implement initState
    if (useWhiteForeground == false) {
      setStatusBarConfig(useWhiteForeground: true);
    }

    super.initState();
  }

  @override
  void dispose() {
    setStatusBarConfig(useWhiteForeground: useWhiteForeground);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SensingWidget(
        maxAngleX: 30,
        maxAngleY: 80,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        middleScale: 1,
        foregroundScale: 1.1,
        backgroundScale: 1.1,
        backgroundWidget: backgroundWidget(),
        middleWidget: middleWidget(),
        foregroundWidget: foregroundWidget(),
      ),
    );
  }

  Widget backgroundWidget() {
    return Container(
      child: getImage('back.png'),
    );
  }

  Widget foregroundWidget() {
    return Container(
      child: getImage('fore.png'),
    );
  }

  Widget middleWidget() {
    // return Center(child: Text('hello'));
    return Container(
        // child: getImage('mid.png'),
        // padding: EdgeInsets.symmetric(horizontal: 100),
        // constraints: BoxConstraints(
        //   maxWidth: 100.dw,
        //   maxHeight: 100.dw,
        // ),
        // child: Center(
        //   child: Text(
        //     "啊发顺的方法恰饭恰饭丰",
        //     style: TextStyle(fontSize: 25.dsp, fontWeight: FontWeight.w400, color: Colors.white),
        //   ),
        // ),
        );
  }

  Image getImage(String s) {
    return Image.asset(
      "assets/images/3d/full_screen/$s",
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.cover,
      scale: 3.0,
    );
  }
}
