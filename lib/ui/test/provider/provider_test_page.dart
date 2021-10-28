import 'package:flutter/material.dart';
import 'package:flutter_ns_test/component/button.dart';
import 'package:flutter_ns_test/extension/size_extension.dart';
import 'package:provider/provider.dart';

import 'provider_test_model.dart';

//https://pub.dev/packages/provider
//provider 插件初识
class ProviderTestPage extends StatefulWidget {
  @override
  State<ProviderTestPage> createState() => _ProviderTestPageState();
}

class _ProviderTestPageState extends State<ProviderTestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ProviderTestPage')),
      body: Consumer<ProviderTestModel>(
        builder: (context, data, child) {
          int num = data.num;//Add Configuration
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(child: Text('$num')),
              DButton(
                padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5.dw),
                color: Theme.of(context).accentColor,
                child: Text(
                  "add",
                  style:
                      TextStyle(fontSize: 16.dsp, fontWeight: FontWeight.w400, color: Colors.white),
                ),
                onPressed: () {
                  Provider.of<ProviderTestModel>(context, listen: false).add();
                },
              ),
              DButton(
                padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5.dw),
                color: Theme.of(context).accentColor,
                child: Text(
                  "sub",
                  style:
                      TextStyle(fontSize: 16.dsp, fontWeight: FontWeight.w400, color: Colors.white),
                ),
                onPressed: () {
                  Provider.of<ProviderTestModel>(context, listen: false).sub();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
