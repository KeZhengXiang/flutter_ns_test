import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ns_test/common/global.dart';
import 'package:flutter_ns_test/component/button.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';
import 'package:flutter_ns_test/extension/size_extension.dart';
import 'package:flutter_ns_test/ui/video/video_resources.dart';
import 'video_helper.dart';

///帮助文档 ： https://jhomlala.github.io/betterplayer/#/cacheconfiguration
///better_player
class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late BetterPlayerController _controller;
  late BetterPlayerConfiguration _configuration;
  late BetterPlayerDataSource source;

  void _listen(BetterPlayerEvent event) {
    logDebug(event.betterPlayerEventType);
    print(event.parameters);
    //BetterPlayerEventType.play
  }

  @override
  void initState() {
    VideoResources.curIndex = 0;
    _configuration = VideoHelper.createConfiguration();
    source = VideoHelper.createDataSource(url: VideoResources.curUrl);
    _controller = BetterPlayerController(_configuration, betterPlayerDataSource: source);

    _controller.addEventsListener(_listen);

    //播放视频前启动预缓存
    // _controller.preCache(source);
    super.initState();
  }

  @override
  void dispose() {
    // _controller.stopPreCache(source);
    _controller.removeEventsListener(_listen);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("video page"),
      ),
      body: Container(
        color: Colors.green,
        width: Global.screenWidth,
        height: Global.screenHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            BetterPlayer(controller: _controller),
            Positioned(
              bottom: 50,
              child: DButton(
                padding: EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5.dw),
                color: Theme.of(context).primaryColor,
                child: Text(
                  "换源",
                  style:
                      TextStyle(fontSize: 16.dsp, fontWeight: FontWeight.w400, color: Colors.white),
                ),
                onPressed: () {
                  _controller.pause();
                  VideoResources.addIndex();

                  print("切换源至： ${VideoResources.curIndex}");
                  _controller.setupDataSource(
                      VideoHelper.createDataSource(url: VideoResources.curUrl));
                },
              ),
            ),
          ],
        ),
        // child: BetterPlayer(controller: _controller),
      ),
    );
  }
}

// //VideoPlayer
// import 'package:flutter/material.dart';
// import 'package:flutter_ns_test/ui/video/video_helper.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoPage extends StatefulWidget {
//   const VideoPage({Key? key}) : super(key: key);
//
//   @override
//   _VideoPageState createState() => _VideoPageState();
// }
//
// class _VideoPageState extends State<VideoPage> {
//   late VideoPlayerController _controller;
//
//   String errorDescription = "";
//
//   @override
//   void initState() {
//     _controller = VideoPlayerController.network(VideoHelper.urlList[VideoHelper.curIndex])
//       ..initialize().then((_) {
//         print("初始化成功");
//         _controller.setLooping(true);
//         _controller.play();
//         setState(() {});
//       });
//
//     _controller.addListener(() {
//       print(_controller.value);
//       if (_controller.value.errorDescription != null) {
//         print(_controller.value.errorDescription!);
//         if (errorDescription == "") {
//           errorDescription = _controller.value.errorDescription!;
//           setState(() {});
//         }
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("video page"),
//       ),
//       // body: Center(
//       body: Container(
//         color: Colors.green,
//         width: double.infinity,
//         height: 500,
//         child: Center(
//           child: _controller.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 )
//               : Container(
//                   child: Center(
//                     child: Text(errorDescription == "" ? "加载中....." : errorDescription),
//                   ),
//                 ),
//         ),
//       ),
//       // ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _controller.value.isPlaying ? _controller.pause() : _controller.play();
//           });
//         },
//         child: Icon(
//           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
//