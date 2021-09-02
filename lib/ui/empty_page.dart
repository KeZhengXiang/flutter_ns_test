import 'package:flutter/material.dart';
import 'package:flutter_ns_test/extension/size_extension.dart';

//空页面
class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("空页面"),
      ),
      body: Center(
        child: Text(
          "空页面",
          style: TextStyle(
              fontSize: 20.dsp, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
