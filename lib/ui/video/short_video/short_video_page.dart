import 'package:flutter/material.dart';
import 'package:flutter_ns_test/common/common.dart';
import 'package:flutter_ns_test/component/empty_widget.dart';
import 'package:flutter_ns_test/model/short_video_entity.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';
import 'package:flutter_ns_test/ui/video/video_resources.dart';

import 'short_video_cell.dart';
import 'short_video_helper.dart';

/// 短视频列表页面
class ShortVideoPage extends StatefulWidget {
  const ShortVideoPage({Key? key}) : super(key: key);

  @override
  _ShortVideoPageState createState() => _ShortVideoPageState();
}

class _ShortVideoPageState extends State<ShortVideoPage> {
  late PageController _controller;
  ShortVideoModel? model;
  bool isInit = false;

  //下拉刷新方法,为list重新赋值
  Future<void> _onRefresh() async {
    logDebug("下拉刷新");

    await Future.delayed(Duration(seconds: 1));
    logDebug("返回数据");
  }

  Future<void> initData() async {
    final jsonStr = await CommonUtil.loadLocalJson(path: "assets/jsons/short_video_json.json");
    model = ShortVideoModel().fromJson(CommonUtil.jsonDecode(jsonStr));
    ShortVideoHelper().model = model;
    ShortVideoHelper().changeIdx(0, model!.videoList, isInit: true);
    isInit = true;
    refreshUI();
  }

  void refreshUI() {
    setState(() {});
  }

  void initState() {
    _controller = PageController();

    //
    initData();
    super.initState();
  }

  @override
  void dispose() {
    // _betterPlayerController.dispose();
    ShortVideoHelper().clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("short video page"),
      // ),
      body: body(),
    );
  }

  Widget getBody() {
    if (isInit == false) {
      return Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
              // color: ,
              ),
        ),
      );
    } else {
      if (model == null || model!.isNotEmpty == false) {
        return Center(
          child: EmptyWidget(),
        );
      } else {
        return body();
      }
    }
  }

  Widget body() {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          //视频列表层
          RefreshIndicator(
            onRefresh: _onRefresh,
            child: PageView.builder(
              // physics: ClampingScrollPhysics(),
              physics: BouncingScrollPhysics(),
              controller: _controller,
              scrollDirection: Axis.vertical,
              itemCount: model?.length ?? 0,
              itemBuilder: (context, index) {
                return ShortVideoCell(index: index, model: model!.videoList[index],onInitIdx:
                (index){
                  ShortVideoHelper().changeIdx(index, model!.videoList);
                },);
              },
              onPageChanged: (int index) {
                logDebug("go  page:$index");
              },
            ),
          ),

          //UI层
          // SafeArea(
          // child:
          // Container(
          //   color: Color(0x0),
          //   child: Stack(
          //     children: [
          //       Positioned(
          //         bottom: 50.dw,
          //         left: 50.dw,
          //         child: DButton(
          //           padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5.dw),
          //           color: Theme
          //               .of(context)
          //               .primaryColor,
          //           child: Text(
          //             "暂停",
          //             style: TextStyle(
          //                 fontSize: 16.dsp, fontWeight: FontWeight.w400, color: Colors.white),
          //           ),
          //           onPressed: () {
          //             _betterPlayerListVideoPlayerController.pause();
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // ),
        ],
      ),
    );
  }
}
