import 'package:flutter/material.dart';
import 'package:flutter_ns_test/common/common.dart';

import 'flutter_interactional_widget.dart';
import 'full_screen_sensing_page.dart';

///
class SensingBannerPage extends StatefulWidget {
  const SensingBannerPage({Key? key}) : super(key: key);

  @override
  _SensingBannerPageState createState() => _SensingBannerPageState();
}

class _SensingBannerPageState extends State<SensingBannerPage> {
  double height = 200;

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
      body: Column(
        children: [
          banner(),
          // Expanded(child: contentWidget())
        ],
      ),
    );
  }

  Widget banner() {
    return SensingWidget(
      width: MediaQuery.of(context).size.width,
      height: height,
      maxAngleY: 30,
      maxAngleX: 40,
      middleScale: 1,
      foregroundScale: 1.1,
      backgroundScale: 1.3,
      backgroundWidget: backgroundWidget(),
      middleWidget: middleWidget(),
      foregroundWidget: foregroundWidget(),
    );
  }

  Widget contentWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (c) {
          return FullScreenSensingPage();
        }));
      },
      child: ListView.builder(
        itemBuilder: (c, i) {
          return ListTile(
            title: Text('hello $i 点击跳转全屏页'),
          );
        },
        itemCount: 8,
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
      child: getImage('mid.png'),
    );
  }

  Image getImage(String s) {
    return Image.asset(
      "assets/images/3d/banner/$s",
      width: MediaQuery.of(context).size.width,
      height: height,
      fit: BoxFit.fill,
      scale: 3.0,
    );
  }
}
