import 'package:flutter_ns_test/generated/json/base/json_convert_content.dart';

//快捷键  Option + J 更新实体模型数据

//
class VersionEntity with JsonConvert<VersionEntity> {
	int? versionCode;
	String? versionName;
	bool? force;
	String? packageName;
	String? title;
	List<String>? contents;
	String? apkDownloadUrl;
	String? iosUrl;
	String? iosVersionName;
	bool? iosForce;
	bool? iosPay;
	bool? iosOpenAccountUI;
	bool? iosMandatoryShow;
	bool? openNewGift;
	bool? openNewPay;
	bool? iosIsShowUI;
	bool? openRobot;
	bool? openChatRoomCm;
	bool? openTask;
}
