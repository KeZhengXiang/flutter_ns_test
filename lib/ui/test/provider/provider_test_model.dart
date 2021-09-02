import 'package:flutter/material.dart';

class ProviderTestModel extends ChangeNotifier {
  ProviderTestModel({this.num = 0});

  int num;

  //更新总数据
  void add() {
    this.num++;
    notifyListeners();
  }

  void sub() {
    this.num--;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
