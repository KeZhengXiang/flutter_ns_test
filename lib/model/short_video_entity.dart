import 'package:flutter_ns_test/generated/json/base/json_convert_content.dart';
import 'package:flutter_ns_test/generated/json/base/json_field.dart';

class ShortVideoModel with JsonConvert<ShortVideoModel> {
  ShortVideoData? data;
  String? msg;
  int? status;

  bool get isNotEmpty {
    if (data != null && data!.videoInfo != null && data!.videoInfo!.length > 0) {
      return true;
    }
    return false;
  }

  int get length {
    if (isNotEmpty) {
      return data!.videoInfo!.length;
    }
    return 0;
  }

  List<ShortVideoInfo> get videoList {
    if (isNotEmpty) {
      return data!.videoInfo!;
    }
    return [];
  }
}

class ShortVideoData with JsonConvert<ShortVideoData> {
  @JSONField(name: "video_info")
  List<ShortVideoInfo>? videoInfo;
  int? sk;
  @JSONField(name: "is_vip")
  int? isVip;
  int? isfree;
  String? showzd;
  String? endplay;
  int? lock;
  @JSONField(name: "dsp_sk")
  int? dspSk;
}

class ShortVideoInfo with JsonConvert<ShortVideoInfo> {
  @JSONField(name: "video_id")
  int? videoId;
  String? name;
  @JSONField(name: "release_time")
  String? releaseTime;
  String? desc;
  String? plays;
  String? likes;
  String? dislikes;
  @JSONField(name: "media_url")
  String? mediaUrl;
  @JSONField(name: "is_complete")
  int? isComplete;
  @JSONField(name: "history_progress")
  int? historyProgress;
  @JSONField(name: "history_index")
  int? historyIndex;
  @JSONField(name: "is_collect")
  int? isCollect;
  @JSONField(name: "is_like")
  int? isLike;
  String? image;
  String? img;
  String? collection;
  String? share;
  ShortVideoInfoAuthor? author;
  @JSONField(name: "class")
  int? xClass;
  int? type;
  String? url;
  @JSONField(name: "show_time")
  int? showTime;
}

class ShortVideoInfoAuthor with JsonConvert<ShortVideoInfoAuthor> {
  @JSONField(name: "author_id")
  int? authorId;
  String? username;
  @JSONField(name: "nick_name")
  String? nickName;
  String? avatar;
  int? channel;
}
