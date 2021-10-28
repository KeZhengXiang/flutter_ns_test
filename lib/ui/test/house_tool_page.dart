import 'package:flutter/material.dart';
import 'package:flutter_ns_test/common/common.dart';
import 'package:flutter_ns_test/router/router_util.dart';

///法拍房计算工具
class HouseToolPage extends StatefulWidget {
  @override
  State<HouseToolPage> createState() => _HouseToolPageState();
}

class _HouseToolPageState extends State<HouseToolPage> {
  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode2 = FocusNode();

  //总金额
  double total = 1000000.00;

  //准备金额
  double reserve = 0.00;

  //退税后金额
  double real = 0.00;

  //需垫资额度
  double endowment = 0.00;

  //垫资佣金/每月  （每月30天计算）
  double c = 0.0128;

  //
  void perform() {
    // RouterUtil.goBlocTestPage(context);
    // return;
    count = 0;
    if (total > 0) {
      // 个税：3%（退税）
      // 增值税：5.3%（退税）
      // 契税：1%
      // 首付三成：30%
      // 贷款担保费：2.1%
      // 佣金：3%
      // 杂费：2000（不超过2000）
      print("total = $total");
      print("付出比例： ${(0.03 + 0.053 + 0.01 + 0.3 + 0.021 + 0.03)}");
      reserve = total * (0.03 + 0.053 + 0.01 + 0.3 + 0.021 + 0.03) + 2000;
      real = total * (0.01 + 0.3 + 0.021 + 0.03) + 2000;

      reserve = reserve / 10000;
      real = real / 10000;

      print("准  备：${reserve.toStringAsFixed(4)}");
      print("退税后：${real.toStringAsFixed(4)}");

      double have = 380000.00;
      var _v = reserve * 10000 - have;
      endowment = (_v > 0) ? _v : 0;
      print("需要垫资 ${endowment.toStringAsFixed(4)} 服务费：${((c / 2) * endowment).toStringAsFixed(4)}");
    }
    setState(() {});
  }

  bool useWhiteForeground = useWhite;

  int count = 0;

  @override
  void initState() {
    if (useWhiteForeground == false) {
      setStatusBarConfig(useWhiteForeground: true);
    }

    // WidgetsBinding.instance?.addPostFrameCallback((Duration timeStamp) {
    //   print("addPostFrameCallback: timeStamp = $timeStamp");
    //
    //   WidgetsBinding.instance?.addPersistentFrameCallback((Duration timeStamp) {
    //     count++;
    //     print("addPersistentFrameCallback: timeStamp = $timeStamp  count = $count");
    //
    //     // //触发一帧的绘制
    //     // WidgetsBinding.instance?.scheduleFrame();
    //     // perform();
    //   });
    // });

    // WidgetsBinding.instance?.removeObserver(observer)

    // perform();
    super.initState();
  }

  @override
  void dispose() {
    setStatusBarConfig(useWhiteForeground: useWhiteForeground);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 20, color: Colors.white);
    return GestureDetector(
      onTap: () {
        if (_focusNode.hasFocus) {
          _focusNode.unfocus();
        }
        if (_focusNode2.hasFocus) {
          _focusNode2.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text("法拍房计算工具", style: style),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      '个税：3%（退税）\n增值税：5.3% （退税）\n契税：1%\n首付三成：30%\n贷款担保费：0.21%\n佣金：3%'
                      '\n杂费：2000（不超过2000）',
                      style: style),
                  SizedBox(height: 10),
                  inputTotalV(),
                  SizedBox(height: 10),
                  Text('准  备：${reserve.toStringAsFixed(4)}万', style: style),
                  Text('退税后：${real.toStringAsFixed(4)}万', style: style),
                  SizedBox(height: 10),
                  inputCsV(),
                  Text('注：垫资费率（月）注：按每月30天计算,  时长默认15天',
                      style: TextStyle(fontSize: 13, color: Colors.white60)),
                  Text(
                      '需要垫资 ${endowment.toStringAsFixed(2)}元\n服务费：${((c / 2) * endowment).toStringAsFixed(2)}元',
                      style: style),
                  SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        onPressed: perform,
                        tooltip: '执行',
                        child: Icon(Icons.exit_to_app_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //通用
  TextEditingController getTextEditingController({String text = ""}) {
    return TextEditingController.fromValue(
      TextEditingValue(
        // 设置内容
        text: text,
        // 保持光标在最后
        selection: TextSelection.fromPosition(
          TextPosition(affinity: TextAffinity.downstream, offset: text.length),
        ),
      ),
    );
  }

  Widget inputTotalV() {
    return Container(
      width: 220,
      height: 50,
      child: TextField(
        focusNode: _focusNode,
        controller: getTextEditingController(text: "${total / 10000}"),
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        onChanged: (String value) {
          print(value);
          double d = 0;
          if (value.isNotEmpty) {
            d = double.parse(value);
          }
          if (d > 0) {
            total = d * 10000;
          }
        },
        decoration: InputDecoration(
          labelText: "额度(万)",
          //页码
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
          contentPadding: EdgeInsets.only(left: 4),
          //边框
          enabledBorder: OutlineInputBorder(
            //未选中时候的颜色
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            //选中时外边框颜色
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }

  Widget inputCsV() {
    return Container(
      width: 220,
      height: 50,
      child: TextField(
        focusNode: _focusNode2,
        controller: getTextEditingController(text: "${c * 100}%"),
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        onChanged: (String value) {
          print(value);
          var d = double.parse(value);
          if (d > 0) {
            c = d;
          }
        },
        decoration: InputDecoration(
          labelText: "垫资费率（月）",
          //页码
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey),
          contentPadding: EdgeInsets.only(left: 4),
          //边框
          enabledBorder: OutlineInputBorder(
            //未选中时候的颜色
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            //选中时外边框颜色
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }
}
