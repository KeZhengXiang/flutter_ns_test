import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ns_test/common/common.dart';
import 'package:flutter_ns_test/extension/size_extension.dart';

//file:toast_util
//toast弹窗相关
class ToastUtil {
  ///显示通用提示文本
  static void showText({
    required String msg,
    Duration duration = const Duration(milliseconds: 2500),
  }) {
    BotToast.showText(
        text: msg,
        duration: duration,
        animationDuration: const Duration(milliseconds: 3000),
        textStyle: TextStyle(fontSize: 14.dsp, color: Colors.white),
        contentColor: Theme.of(navigatorKey.currentContext!).backgroundColor);
  }

  ///显示加载中弹窗
  static CancelFunc showMyLoading() =>
      BotToast.showWidget(toastBuilder: (context) => loadingWidget);

  ///手动关闭所有弹窗
  static void closeAllLoading() => BotToast.closeAllLoading();

  ///弹出窗口
  static CancelFunc showWidget(
      {required ToastBuilder toastBuilder, UniqueKey? key, String? groupKey}) {
    //示例
    // CancelFunc cancelFunc = BotToast.showWidget(toastBuilder: (context) {
    //   return Container(
    //     width: 200,
    //     height: 200,
    //     color: Colors.blue,
    //     child: Center(
    //       child: Text("Hello World"),
    //     ),
    //   );
    // });
    return BotToast.showWidget(toastBuilder: toastBuilder, key: key, groupKey: groupKey);
  }
}
