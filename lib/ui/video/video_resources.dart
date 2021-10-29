class VideoResources {
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

  static String get curUrl {
    return urlList[curIndex];
  }

  static String getUrl(int index) {
    return urlList[index];
  }

  static int get length {
    return urlList.length;
  }

  static void addIndex() {
    if (curIndex >= urlList.length - 1) {
      curIndex = 0;
    } else {
      curIndex++;
    }
  }
}
