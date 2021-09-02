import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';

enum CTBCallbackType {
  complete, //倒计时完成回调
  click //点击回调
}

/// 倒计时文本圆角按钮
class KBtnTextRoundCountdown extends StatefulWidget {
  final String title;
  final int microseconds; //倒计时时长
  final Function(CTBCallbackType type) callback;

  final double radius;
  final double width;
  final double height;

  KBtnTextRoundCountdown(this.title, this.microseconds,
      {Key? key,
      required this.callback,
      required this.width,
      required this.height,
      required this.radius})
      : super(key: key);

  @override
  _KBtnTextRoundCountdownState createState() => _KBtnTextRoundCountdownState();
}

class _KBtnTextRoundCountdownState extends State<KBtnTextRoundCountdown> {
  Timer? timer;
  int curMicroseconds = 0;

  @override
  void initState() {
    curMicroseconds = widget.microseconds;
    if (curMicroseconds >= 1) {
      timer = Timer.periodic(Duration(milliseconds: 1000), (Timer timer) {
        if (!this.mounted) {
          return;
        }
        setState(() {
          curMicroseconds -= 1;
        });
        log(curMicroseconds);
        if (curMicroseconds <= 0) {
          widget.callback(CTBCallbackType.complete);
          timer.cancel();
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String tip = (curMicroseconds <= 0) ? widget.title : "$curMicroseconds 秒";
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        splashColor: Color(0xF6666666),
        highlightColor: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
        onTap: () {
          widget.callback(CTBCallbackType.click);
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          child: Center(
            child: Text(tip,
                style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500)),
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0.5), // 边色与边宽度
            color: Color(0x66666666), // 底色
            borderRadius: BorderRadius.circular(widget.radius), // 圆角度
          ), // 也可控件一边圆角大小
        ),
      ),
    );
  }
}
