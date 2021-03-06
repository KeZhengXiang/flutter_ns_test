import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ns_test/model/short_video_entity.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';

import 'short_video_helper.dart';

//缓存版本   独立播放器是 VideoItem
class VideoItem extends StatefulWidget {
  final int index;
  final ShortVideoInfo model;
  // final BetterPlayerController controller;

  const VideoItem({Key? key, required this.index, required this.model
    // , required this.controller
  })
      : super(key: key);

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late BetterPlayerController _controller;

  void initVideo() {
    _controller = ShortVideoHelper().getController(widget.index, widget.model);
    _controller.addEventsListener(_listen);
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
    _controller.removeEventsListener(_listen);
    ShortVideoHelper().subCtr(_controller);
    _controller.pause();
    // _controller.dispose();
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
