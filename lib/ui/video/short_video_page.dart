import 'package:flutter/material.dart';
import 'package:flutter_ns_test/common/global.dart';

class ShortVideoPage extends StatefulWidget {
  const ShortVideoPage({Key? key}) : super(key: key);

  @override
  _ShortVideoPageState createState() => _ShortVideoPageState();
}

class _ShortVideoPageState extends State<ShortVideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("short video page"),
        ),
        body: Container(
          color: Colors.green,
          width: Global.screenWidth,
          height: Global.screenHeight,
        ));
  }
}
