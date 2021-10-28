import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ns_test/common/global.dart';

///帮助文档 ： https://jhomlala.github.io/betterplayer/#/cacheconfiguration
class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final url = "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  final url1 =
      "https://testc.hzsy66.cn/short_video/20210916/m3u8/playlist.m3u8?auth_key=1634178600-a3f390d88e4c41f2747bfa2f1b5f87db-0-479f5e16941708ed594fac02683dfca8";
  final url2 = "https://testc.hzsy66.cn/upload/short_video/202108091446/m3u8/1.m3u8";
  final url3 =
      "https://v11.tkzyapi.com/20210914/hylcFIpO/1000kb/hls/index.m3u8?auth_key=1634707825-812b4ba287f5ee0bc9d43bbf5bbe87fb-0-c20242623ac0162944fe69dcac18e1e7";

  late BetterPlayerController _controller;
  late BetterPlayerConfiguration _configuration;

  // void initConfiguration(){
  //
  // }

  void _listen(BetterPlayerEvent event) {}

  @override
  void initState() {
    _configuration = BetterPlayerConfiguration(
      autoPlay: true,
      looping: true,

      // startAt: Duration(seconds: 2),

      //在初始化小部件时显示控件。
      showPlaceholderUntilPlay: true,

      // errorBuilder: (BuildContext context, String? errorMessage){
      //   return Center(
      //     child: Container(
      //       width: 50,
      //       height: 50,
      //       color: Colors.white,
      //       child: Icon(Icons.error_outline,size: 30),
      //     ),
      //   );
      // },

      //需要获得真实宽高比 ？
      // aspectRatio: 16/9,

      // //占位符在初始化视频之前显示在视频下方
      // placeholder: Center(
      //   child: Container(
      //     width: 100,
      //     height: 30,
      //     color: Colors.green,
      //   ),
      // ),
      // // 占位符位置。如果为false，则占位符为显示在底部，所以用户需要手动隐藏它。default = true
      // placeholderOnTop: true,
      //
      // //放置在视频和控件之间的小部件
      // overlay: Center(
      //   child: Container(
      //     width: 30,
      //     height: 100,
      //     color: Colors.red,
      //   ),
      // ),

      //玩家是否会全屏开始 default = false
      // fullScreenByDefault: true,

      //定义玩家是否会全屏睡眠 default = true
      allowedScreenSleep: true,
      //定义在全屏中使用的宽高比
      // fullScreenAspectRatio: 1,

      fit: BoxFit.contain,
    );
    BetterPlayerDataSource source = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url2,
      //视频分辨率
      resolutions: {"LOW": url2, "MEDIUM": url2, "LARGE": url2, "EXTRA_LARGE": url2},

      //缓存配置
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        //启用网络数据源缓存
        preCacheSize: 10 * 1024 * 1024,
        //下载的大小
        maxCacheSize: 10 * 1024 * 1024,
        //最大缓存大小
        maxCacheFileSize: 10 * 1024 * 1024,
        //以字节为单位的每个单独文件的最大大小。
        ///Android only option to use cached video between app sessions
        key: "cacheVideoKey",
      ),

      //缓冲配置
      bufferingConfiguration: BetterPlayerBufferingConfiguration(
        minBufferMs: 50000, //最小持续时间 ms
        maxBufferMs: 13107200, //最大持续时间 ms
        bufferForPlaybackMs: 2500, //播放开始时必须缓冲的媒体的默认持续时间 ms
        bufferForPlaybackAfterRebufferMs: 5000, //为恢复播放而必须缓冲的媒体的默认持续时间
      ),

      //
      notificationConfiguration: BetterPlayerNotificationConfiguration(
        showNotification: true,
        //显示通知
        title: "video title",
        author: "dong dong",
        imageUrl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/African_Bush_Elephant.jpg/1200px-African_Bush_Elephant.jpg",
        activityName: "MainActivity",
      ),
    );

    _controller = BetterPlayerController(
      _configuration,
      betterPlayerDataSource: source,
    );

    _controller.addEventsListener(_listen);

    //播放视频前启动预缓存
    _controller.preCache(source);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeEventsListener(_listen);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("video player"),
      ),
      body: Container(
        color: Colors.green,
        width: Global.screenWidth,
        height: Global.screenHeight,
        child: Expanded(
          child: BetterPlayer(controller: _controller),
        ),
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
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
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(
//         // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
//         url3
//     )
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       });
//
//
//     _controller.addListener(() {
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//           child: _controller.value.isInitialized
//               ? AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           )
//               : Container(),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               _controller.value.isPlaying
//                   ? _controller.pause()
//                   : _controller.play();
//             });
//           },
//           child: Icon(
//             _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//           ),
//         ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }
//
