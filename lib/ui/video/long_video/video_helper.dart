import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoHelper {
  static final VideoHelper _instance = VideoHelper._internal();

  factory VideoHelper() {
    return _instance;
  }

  VideoHelper._internal() {
    init();
  }

  void init() {
    print("这里初始化");
  }

  //=======================================================================================

  static BetterPlayerConfiguration createConfiguration() {
    return BetterPlayerConfiguration(
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
  }

  static BetterPlayerDataSource createDataSource({required String url, bool isAdd = false}) {
    return BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url,
      //视频分辨率
      // resolutions: {"LOW": url2, "MEDIUM": url2, "LARGE": url2, "EXTRA_LARGE": url2},

      //缓存配置
      cacheConfiguration: BetterPlayerCacheConfiguration(useCache: true),

      //缓冲配置
      bufferingConfiguration: BetterPlayerBufferingConfiguration(
        bufferForPlaybackMs: 1000, //播放开始时必须缓冲的媒体的默认持续时间 ms
        bufferForPlaybackAfterRebufferMs: 1000, //为恢复播放而必须缓冲的媒体的默认持续时间
      ),

      //
      notificationConfiguration: BetterPlayerNotificationConfiguration(
        showNotification: true,
        //显示通知
        title: "video title",
        author: "dong dong",
        // imageUrl:
        //     "https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/African_Bush_Elephant.jpg/1200px-African_Bush_Elephant.jpg",
        activityName: "MainActivity",
      ),
    );
  }
}
