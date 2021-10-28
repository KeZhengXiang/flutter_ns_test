import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoHelper {
  static var curIndex = 0;

  static final urlList2 = [
    //0 [android:true,  ios:true    ATS[yes]-true ATS[no]-true]
    "https://testc.hzsy66.cn/upload/short_video/202108091446/m3u8/1.m3u8",
    //1 [android:true,  ios:be-true?    ATS[yes]-true  ATS[no]-true] 中初始化时间
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    //2 [android:true,  ios:false    ATS[yes]-true ATS[no]-true]  电影
    "https://v11.tkzyapi.com/20210914/hylcFIpO/1000kb/hls/index"
        ".m3u8?auth_key=1634707825-812b4ba287f5ee0bc9d43bbf5bbe87fb-0-c20242623ac0162944fe69dcac18e1e7",
    //3 [android:false,  ios:false    ATS[yes]-false ATS[no] - false]
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    //4 [android:false,  ios:false    ATS[yes]-true ATS[no]-true] 超长初始化时间
    "http://sample.vodobox.com/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8",
    //5 [android:false,  ios:false    ATS[yes]-false ATS[no]-false]
    "https://testc.hzsy66.cn/short_video/20210916/m3u8/playlist"
        ".m3u8?auth_key=1634178600-a3f390d88e4c41f2747bfa2f1b5f87db-0-479f5e16941708ed594fac02683dfca8",
  ];

// static final urlList = [
//   //0 [android:true,  ios:be-true?    ATS[yes]-true  ATS[no]-true] 中初始化时间
//   "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
//   //1 [android:false,  ios:false    ATS[yes]-false ATS[no]-false]
//   "https://testc.hzsy66.cn/short_video/20210916/m3u8/playlist"
//       ".m3u8?auth_key=1634178600-a3f390d88e4c41f2747bfa2f1b5f87db-0-479f5e16941708ed594fac02683dfca8",
//   //2 [android:true,  ios:true    ATS[yes]-true ATS[no]-true]
//   "https://testc.hzsy66.cn/upload/short_video/202108091446/m3u8/1.m3u8",
//   //3 [android:true,  ios:false    ATS[yes]-true ATS[no]-true]  电影
//   "https://v11.tkzyapi.com/20210914/hylcFIpO/1000kb/hls/index"
//       ".m3u8?auth_key=1634707825-812b4ba287f5ee0bc9d43bbf5bbe87fb-0-c20242623ac0162944fe69dcac18e1e7",
//   //4 [android:false,  ios:false    ATS[yes]-false ATS[no] - true]
//   "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
//
//   //5 [android:false,  ios:false    ATS[yes]-true ATS[no]-true] 超长初始化时间
//   "http://sample.vodobox.com/skate_phantom_flex_4k/skate_phantom_flex_4k.m3u8",
// ];

  static final urlList = [
    "https://v10.dious.cc/20210915/144vUJxD/1000kb/hls/index"
        ".m3u8?auth_key=1635413738-6c8349cc7260ae62e3b1396831a8398f-0-9de61b080de57f929d8e5faedb2ca777",
    "https://vod8.wenshibaowenbei.com/20210722/vucUEjBi/1000kb/hls/index.m3u8?auth_key=1635413820-43ec5"
        "17d68b6edd3015b3edc9a11367b-0-a1f7242f55424a85dd9365279791ba82",
    "https://1251316161.vod2.myqcloud.com/007a649dvodcq1251316161/45d870155285890812491498931/24c2SGTVjr"
        "cA.mp4?auth_key=1635413856-32bb90e8976aab5298d5da10fe66f21d-0-d37f68f616ef13f77aa8b324ec3c1433",
  ];

  static BetterPlayerConfiguration createBetterPlayerConfiguration() {
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

  static BetterPlayerDataSource createBetterPlayerDataSource(
      {required String url, bool isAdd = false}) {
    return BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url,
      //视频分辨率
      // resolutions: {"LOW": url2, "MEDIUM": url2, "LARGE": url2, "EXTRA_LARGE": url2},

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
  }
}
