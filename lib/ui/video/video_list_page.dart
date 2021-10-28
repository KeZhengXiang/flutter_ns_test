// import 'package:flutter/material.dart';
//
// class VideoListPage extends StatefulWidget {
//   const VideoListPage({Key? key}) : super(key: key);
//
//   @override
//   _VideoListPageState createState() => _VideoListPageState();
// }
//
// class _VideoListPageState extends State<VideoListPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ns_test/common/global.dart';
import 'package:flutter_ns_test/ui/video/video_helper.dart';

///自动播放列表
class VideoListPage extends StatefulWidget {
  const VideoListPage({Key? key}) : super(key: key);

  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage> {
  late List<BetterPlayerDataSource> dataSourceList;

  List<BetterPlayerDataSource> createDataSet() {
    List<BetterPlayerDataSource> dataSourceList = [];
    VideoHelper.urlList.forEach((element) {
      dataSourceList.add(VideoHelper.createBetterPlayerDataSource(url: element));
    });
    return dataSourceList;
  }

  @override
  void initState() {
    // TODO: implement initState
    dataSourceList = createDataSet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("video list page"),
      ),
      body: Container(
        color: Colors.green,
        width: Global.screenWidth,
        height: Global.screenHeight,
        child: BetterPlayerPlaylist(
            betterPlayerConfiguration: VideoHelper.createBetterPlayerConfiguration(),
            betterPlayerPlaylistConfiguration: const BetterPlayerPlaylistConfiguration(
              nextVideoDelay: const Duration(milliseconds: 3000),
              loopVideos: true,
              initialStartIndex: 0,
            ),
            betterPlayerDataSourceList: dataSourceList),
      ),
    );
  }
}
