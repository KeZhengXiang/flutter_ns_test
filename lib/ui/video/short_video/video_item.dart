import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ns_test/model/short_video_entity.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';

import 'short_video_helper.dart';

class VideoItem extends StatefulWidget {
  final int index;
  final ShortVideoInfo model;

  const VideoItem({Key? key, required this.index, required this.model}) : super(key: key);

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late BetterPlayerController _controller;
  late BetterPlayerDataSource _source;

  //默认媒体
  String defaultMediaUrl = "https://ks3-cn-beijing.ksyun.com/videotest/20210604160046"
      ".mp4?auth_key=1635480214-3416a75f4cea9109507cacd8e2f2aefc-0-8e89675a3bae43c11d2ad366626efff0";

  void initVideo() {
    final _configuration = ShortVideoHelper.createConfiguration(widget.model);
    _source = ShortVideoHelper.createDataSource(widget.model);
    _controller = BetterPlayerController(_configuration, betterPlayerDataSource: _source);
    // _controller = ShortVideoHelper().createController(widget.index, widget.model);
    _controller.addEventsListener(_listen);

    //播放视频前启动预缓存
    // _controller.preCache(_source);
  }

  void _listen(BetterPlayerEvent event) {
    logDebug(event.betterPlayerEventType);
    print(event.parameters);
    //BetterPlayerEventType.play
    if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
      ShortVideoHelper().pause(ctr: _controller);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _controller.stopPreCache(_source);
    _controller.removeEventsListener(_listen);
    ShortVideoHelper().subCtr(_controller);
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initVideo();
    ShortVideoHelper().addCtr(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(controller: _controller);
  }
}
