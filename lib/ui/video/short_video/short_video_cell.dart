import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ns_test/common/global.dart';
import 'package:flutter_ns_test/component/image_net.dart';
import 'package:flutter_ns_test/model/short_video_entity.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';
import 'package:flutter_ns_test/ui/video/short_video/video_item.dart';
import 'package:flutter_ns_test/ui/video/video_resources.dart';

import 'short_video_helper.dart';
import 'video_item2.dart';

class ShortVideoCell extends StatefulWidget {
  final int index;
  final ShortVideoInfo model;

  final Function(int idx) onInitIdx;

  const ShortVideoCell(
      {Key? key, required this.index, required this.model, required this.onInitIdx})
      : super(key: key);

  @override
  _ShortVideoCellState createState() => _ShortVideoCellState();
}

class _ShortVideoCellState extends State<ShortVideoCell> {
  @override
  void initState() {
    logDebug("initState  ${widget.index}");
    widget.onInitIdx(widget.index);
    super.initState();
  }

  @override
  void dispose() {
    logDebug("dispose  ${widget.index}");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logDebug("build  ${widget.index}");
    return Container(
      // color: Colors.cyan,
      color: Colors.primaries[widget.index],
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      // child: Center(
      //   child: Text('${widget.index}'),
      // ),
      // child: BetterPlayerListVideoPlayer(
      //   VideoHelper.createBetterPlayerDataSource(url: VideoHelper.urlList[widget.index]),
      //   configuration: VideoHelper.createBetterPlayerConfiguration(),
      //   key: Key("video:${VideoHelper.urlList[widget.index]}"),
      //   playFraction: 1,
      //   betterPlayerListVideoPlayerController: widget.controller,
      // ),
      child: Stack(
        children: [
          // DImageNet(
          //   widget.model.image ?? "",
          //   radius: 4,
          //   fit: BoxFit.cover,
          // ),
          // BetterPlayer(controller: _controller),

          VideoItem(index: widget.index, model: widget.model),
          // VideoItem2(index: widget.index, model: widget.model),
        ],
      ),
    );
  }
}
