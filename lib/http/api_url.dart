import 'package:flutter_ns_test/common/global.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';

class ApiUrl {
  ///调试修改区域
  // static const _debugBaseUrl = _testBaseUrl; //debug 测试服调试
  static const _debugBaseUrl = _onlineBaseUrl; //debug 正式服调试
  static const _isForce = false; //是否使用线上强制更新

  ///****************************不准动**************************************
  static const _testBaseUrl = "https://dev.weaves.cn/airdrop/"; //测试服域名
  // static const _testBaseUrl = "http://192.168.31.83:8080/airdrop/"; //后端本地服域名
  static const _onlineBaseUrl = "https://www.weaves.cn/airdrop/"; //正式服域名
  ///****************************不准动**************************************

  ///域名release线上版本锁定
  static String get baseUrl {
    if (Global.isRelease) {
      logDebug("当前运行版本： release");
      return _onlineBaseUrl;
    } else {
      logDebug("当前运行版本： debug");
    }
    return _debugBaseUrl;
  }

  ///是否使用线上强制更新: release线上版本锁定使用
  static bool get isForce {
    if (Global.isRelease) {
      return true;
    }
    return _isForce;
  }

  ///****************************  配置 **************************************

  static const appVersion = "rest/api/appversion";

  ///上传图片
  static const upLoadCover = "a/live/uploadcover";

  ///客服中心
  static const agents = 'a/live2/agents';
}
