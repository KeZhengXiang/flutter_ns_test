import 'dart:collection';
import 'dart:convert';
import 'dart:ui';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ns_test/common/global.dart';
import 'package:flutter_ns_test/component/image_net.dart';
import 'package:flutter_ns_test/model/short_video_entity.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';
import 'package:flutter_ns_test/ui/video/video_resources.dart';

class ShortVideoHelper {
  static final ShortVideoHelper _instance = ShortVideoHelper._internal();

  factory ShortVideoHelper() {
    return _instance;
  }

  ShortVideoHelper._internal() {
    init();
  }

  void init() {
    print("这里初始化");
  }

  //=======================================================================================

  List<BetterPlayerController> _videoPools = [];

  void addCtr(BetterPlayerController ctr) {
    _videoPools.add(ctr);
  }

  void subCtr(BetterPlayerController ctr) {
    _videoPools.remove(ctr);
  }

  void pause({BetterPlayerController? ctr}) {
    _videoPools.forEach((e) {
      if (e == ctr) {
      } else if (e.isPlaying() ?? false) {
        e.pause();
      }
    });
  }

  //========================================预缓存管理===============================================
  //有序的预缓存数据源池
  var _videoCtrHashMap = LinkedHashMap<String, BetterPlayerController>();
  var _videoSourceHashMap = LinkedHashMap<String, BetterPlayerDataSource>();

  //缓存前后视频数量  [*000000]  [000*000]  [000000*]  [0*00000]  [00000*0]
  final maxCache = 2;

  //
  void changeIdx(int curIdx, List<ShortVideoInfo> list) {
    if (curIdx <= maxCache - 1) {
      curIdx = 0;
    }
    if (curIdx >= list.length - 1) {
      return;
    }

    int endIndex = list.length;
    if (endIndex > curIdx + 3) {
      endIndex = curIdx + 3;
    }

    //当前缓存的集合
    List<String> caches = _videoCtrHashMap.keys.toList();
    //开始缓存【curIdx，endIndex】视频
    for (int i = curIdx; i < endIndex; ++i) {
      final String key = list[i].mediaUrl!;
      late BetterPlayerDataSource _source;
      late BetterPlayerController _controller;
      if (_videoCtrHashMap.containsKey(key)) {
        // _source = _videoSourceHashMap[key]!;
        // _controller = _videoCtrHashMap[key]!;
      } else {
        final _configuration = ShortVideoHelper.createConfiguration(list[i]);
        _source = ShortVideoHelper.createDataSource(list[i]);
        _controller = BetterPlayerController(_configuration, betterPlayerDataSource: _source);
        _videoSourceHashMap[key] = _source;
        _videoCtrHashMap[key] = _controller;
        _controller.preCache(_source);
      }
      caches.remove(key);
    }

    //去掉放弃缓存的
    caches.forEach((key) {
      _videoCtrHashMap[key]!.stopPreCache(_videoSourceHashMap[key]!);
      _videoSourceHashMap.remove(key);
      _videoCtrHashMap.remove(key);
    });
  }

  BetterPlayerController createController(int index, ShortVideoInfo model) {
    final String key = model.mediaUrl!;
    if (_videoCtrHashMap.containsKey(key)) {
      return _videoCtrHashMap[key]!;
    } else {
      logDebug("object");
      final _configuration = ShortVideoHelper.createConfiguration(model);
      final _source = ShortVideoHelper.createDataSource(model);
      return BetterPlayerController(_configuration, betterPlayerDataSource: _source);
    }
  }

  ///预缓存未来的2个
  /// * - [curIdx] 当前执行位置
  // void preCacheNextSource(int curIdx) {
  //   //ShortVideoHelper.createDataSource(url: VideoResources.getUrl(widget.index))
  //   if (curIdx >= VideoResources.urlList.length - 1) {
  //     _sourcePools.forEach((key, value) {
  //       _controller.stopPreCache(_source);
  //     });
  //     return;
  //   }
  //
  //   for (int i = curIdx;) {
  //
  //   }
  // }

  //=======================================================================================

  static BetterPlayerConfiguration createConfiguration(ShortVideoInfo model) {
    return BetterPlayerConfiguration(
      autoPlay: true,
      looping: true,

      //需要获得真实宽高比 ？
      aspectRatio: Global.screenWidth / Global.screenHeight,

      controlsConfiguration: BetterPlayerControlsConfiguration(
        // textColor: Colors.black,
        // iconsColor: Colors.black,
        // enableMute: false,
        showControls: false,
      ),

      // autoDetectFullscreenDeviceOrientation:true,

      // startAt: Duration(seconds: 2),

      //在初始化小部件时显示控件。
      showPlaceholderUntilPlay: false,

      //错误构建展位部件
      errorBuilder: (BuildContext context, String? errorMessage) {
        return Center(
          child: Container(
            width: 50,
            height: 50,
            color: Colors.white,
            child: Icon(Icons.error_outline, size: 30),
          ),
        );
      },

      //占位符在初始化视频之前显示在视频下方
      placeholder: Stack(
        children: [
          DImageNet(model.image ?? "", radius: 4, fit: BoxFit.cover),
          //高斯模糊
          // BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          //   // child: DImageNet(model.image ?? "", radius: 4, fit: BoxFit.cover),
          //   child: Container(
          //     color: Colors.white.withOpacity(0.1),
          //     width: 300,
          //     height: 300,
          //   ),
          // ),
        ],
      ),

      // 占位符位置。如果为false，则占位符为显示在底部，所以用户需要手动隐藏它。default = true
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
      // allowedScreenSleep: true,

      //定义在全屏中使用的宽高比
      // fullScreenAspectRatio: 1,

      fit: BoxFit.contain,
    );
  }

  static BetterPlayerDataSource createDataSource(ShortVideoInfo model) {
    return BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      model.mediaUrl ?? "",
      //视频分辨率
      // resolutions: {"LOW": url2, "MEDIUM": url2, "LARGE": url2, "EXTRA_LARGE": url2},

      //缓存配置
      cacheConfiguration: BetterPlayerCacheConfiguration(useCache: true),

      //缓冲配置
      bufferingConfiguration: BetterPlayerBufferingConfiguration(
        bufferForPlaybackMs: 100, //播放开始时必须缓冲的媒体的默认持续时间 ms
        bufferForPlaybackAfterRebufferMs: 100, //为恢复播放而必须缓冲的媒体的默认持续时间
      ),

      //通知
      notificationConfiguration: BetterPlayerNotificationConfiguration(
        showNotification: true,
        title: model.name,
        author: "dong dong",
        imageUrl: model.image,
        activityName: "MainActivity",
      ),
    );
  }

//=======================================================================================

}

// class 配置 {
//   /// Play the video as soon as it's displayed
//   /// 视频一显示就开始播放
//   final bool autoPlay;
//
//   /// 在某个位置开始视频
//   final Duration? startAt;
//
//   /// Whether or not the video should loop
//   /// 视频是否应该循环
//   final bool looping;
//
//   /// When the video playback runs  into an error, you can build a custom
//   /// error message.
//   /// 当视频播放遇到错误时，您可以构建自定义错误消息
//   final Widget Function(BuildContext context, String? errorMessage)? errorBuilder;
//
//   /// The Aspect Ratio of the Video. Important to get the correct size of the
//   /// video!
//   ///
//   /// Will fallback to fitting within the space allowed.
//   /// 视频的纵横比。重要的是要得到正确的大小视频!
//   /// 将回退到允许的空间内。
//   final double? aspectRatio;
//
//   /// The placeholder is displayed underneath the Video before it is initialized
//   /// or played.
//   /// 占位符在初始化视频之前显示在视频下方
//   final Widget? placeholder;
//
//   /// Should the placeholder be shown until play is pressed
//   /// 是否应该显示占位符直到play被按下
//   final bool showPlaceholderUntilPlay;
//
//   /// Placeholder position of player stack. If false, then placeholder will be
//   /// displayed on the bottom, so user need to hide it manually. Default is
//   /// true.
//   /// 玩家栈的占位符位置。如果为false，则占位符为
//   /// 显示在底部，所以用户需要手动隐藏它。默认是true
//   final bool placeholderOnTop;
//
//   /// A widget which is placed between the video and the controls
//   /// 放置在视频和控件之间的小部件
//   final Widget? overlay;
//
//   /// Defines if the player will start in fullscreen when play is pressed
//   /// 定义当按下play键时，玩家是否会全屏开始
//   final bool fullScreenByDefault;
//
//   /// Defines if the player will sleep in fullscreen or not
//   /// 定义玩家是否会全屏睡眠
//   final bool allowedScreenSleep;
//
//   /// Defines aspect ratio which will be used in fullscreen
//   /// 定义在全屏中使用的宽高比
//   final double? fullScreenAspectRatio;
//
//   /// Defines the set of allowed device orientations on entering fullscreen
//   /// 定义一组允许进入全屏的设备方向
//   final List<DeviceOrientation> deviceOrientationsOnFullScreen;
//
//   /// Defines the system overlays visible after exiting fullscreen
//   /// 定义在退出全屏后可见的系统覆盖
//   final List<SystemUiOverlay> systemOverlaysAfterFullScreen;
//
//   /// Defines the set of allowed device orientations after exiting fullscreen
//   /// 定义退出全屏后允许的设备方向集
//   final List<DeviceOrientation> deviceOrientationsAfterFullScreen;
//
//   /// Defines a custom RoutePageBuilder for the fullscreen
//   /// 为全屏定义一个自定义的RoutePageBuilder
//   final BetterPlayerRoutePageBuilder? routePageBuilder;
//
//   /// Defines a event listener where video player events will be send
//   /// 定义一个事件监听器，视频播放器事件将被发送
//   final Function(BetterPlayerEvent)? eventListener;
//
//   ///Defines subtitles configuration
//   ///定义字幕配置
//   final BetterPlayerSubtitlesConfiguration subtitlesConfiguration;
//
//   ///Defines controls configuration
//   ///定义控制配置
//   final BetterPlayerControlsConfiguration controlsConfiguration;
//
//   ///Defines fit of the video, allows to fix video stretching, see possible
//   ///values here: https://api.flutter.dev/flutter/painting/BoxFit-class.html
//   final BoxFit fit;
//
//   ///Defines rotation of the video in degrees. Default value is 0. Can be 0, 90, 180, 270.
//   ///Angle will rotate only video box, controls will be in the same place.
//   ///定义视频的旋转角度。默认值为0。可以是0、90、180、270。
//   /// 角度将只旋转视频框，控件将在相同的位置。
//   final double rotation;
//
//   ///Defines function which will react on player visibility changed
//   ///定义函数，该函数将在玩家可见性改变时做出反应
//   final Function(double visibilityFraction)? playerVisibilityChangedBehavior;
//
//   ///Defines translations used in player. If null, then default english translations
//   ///will be used.
//   ///定义在播放器中使用的翻译。如果为空，则默认为英文翻译
//   final List<BetterPlayerTranslations>? translations;
//
//   ///Defines if player should auto detect full screen device orientation based
//   ///on aspect ratio of the video. If aspect ratio of the video is < 1 then
//   ///video will played in full screen in portrait mode. If aspect ratio is >= 1
//   ///then video will be played horizontally. If this parameter is true, then
//   ///[deviceOrientationsOnFullScreen] and [fullScreenAspectRatio] value will be
//   /// ignored.
//   /// 定义玩家是否应该基于全屏设备方向自动检测
//   // 视频的纵横比。如果视频的纵横比< 1则
//   // 视频将在竖屏模式全屏播放。如果宽高比为>= 1
//   // 然后视频将水平播放。如果该参数为true，则
//   // [deviceOrientationsOnFullScreen]和[fullScreenAspectRatio]的值将是
//   //  /忽略。
//   final bool autoDetectFullscreenDeviceOrientation;
//
//   ///Defines if player should auto detect full screen aspect ration of the video.
//   ///If [deviceOrientationsOnFullScreen] is true this is done automaticaly also.
//   ///定义玩家是否应该自动检测视频的全屏纵横比。
//   final bool autoDetectFullscreenAspectRatio;
//
//   ///Defines flag which enables/disables lifecycle handling (pause on app closed,
//   ///play on app resumed). Default value is true.
//   ///定义启用/禁用生命周期处理的标志(在应用程序关闭时暂停
//   final bool handleLifecycle;
//
//   ///Defines flag which enabled/disabled auto dispose of
//   ///[BetterPlayerController] on [BetterPlayer] dispose. When it's true and
//   ///[BetterPlayerController] instance has been attached to [BetterPlayer] widget
//   ///and dispose has been called on [BetterPlayer] instance, then
//   ///[BetterPlayerController] will be disposed.
//   ///Default value is true.
//   ///定义启用/禁用自动处置的标志
//   // [BetterPlayerController] on [BetterPlayer] dispose. //当它是true
//   // [BetterPlayerController]实例已附加到[BetterPlayer]小部件
//   // 在[BetterPlayer]实例中调用了dispose，那么
//   // [BetterPlayerController]将被处置。
//   final bool autoDispose;
//
//   ///Flag which causes to player expand to fill all remaining space. Set to false
//   ///to use minimum constraints
//   ///导致玩家扩展到所有剩余空间的标志。设置为假使用最小约束
//   final bool expandToFill;
//
//   ///Flag which causes to player use the root navigator to open new pages.
//   ///Default value is false.
//   ///使玩家使用根导航器打开新页面的标志。
//   // 默认值为false。
//   final bool useRootNavigator;
// }
