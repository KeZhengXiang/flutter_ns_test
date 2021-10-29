// import 'package:flutter/material.dart';
// import 'package:flutter_ns_test/model/short_video_entity.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoItem2 extends StatefulWidget {
//   final int index;
//   final ShortVideoInfo model;
//
//   const VideoItem2({Key? key, required this.index, required this.model}) : super(key: key);
//
//   @override
//   State<VideoItem2> createState() => _VideoItem2State();
// }
//
// class _VideoItem2State extends State<VideoItem2> {
//   late VideoPlayerController _controller;
//
//   String errorDescription = "";
//
//   //默认媒体
//   String defaultMediaUrl = "https://ks3-cn-beijing.ksyun.com/videotest/20210604160046"
//       ".mp4?auth_key=1635480214-3416a75f4cea9109507cacd8e2f2aefc-0-8e89675a3bae43c11d2ad366626efff0";
//
//   void initVideo() {
//     _controller = VideoPlayerController.network(widget.model.mediaUrl ?? defaultMediaUrl)
//       ..initialize().then((_) {
//         print("初始化成功");
//         // _controller.setVolume(0);
//         _controller.setLooping(true);
//         _controller.play();
//         setState(() {});
//       });
//
//     _controller.addListener(_listen);
//   }
//
//   void _listen() {
//     print(_controller.value);
//     if (_controller.value.errorDescription != null) {
//       print(_controller.value.errorDescription!);
//       if (errorDescription == "") {
//         errorDescription = _controller.value.errorDescription!;
//         setState(() {});
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     initVideo();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _controller.removeListener(_listen);
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black,
//       width: double.infinity,
//       height: double.infinity,
//       child: Center(
//         child: _controller.value.isInitialized
//             ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller),
//               )
//             : Container(
//                 child: Center(
//                   child: Text(
//                     errorDescription == "" ? "加载中....." : errorDescription,
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
