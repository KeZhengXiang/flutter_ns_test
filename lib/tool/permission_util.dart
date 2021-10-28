import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ns_test/common/global.dart';
import 'package:flutter_ns_test/tool/log_utils.dart';
import 'package:permission_handler/permission_handler.dart';

///权限管理
// class PermissionUtil {
//   static _log(Object object) {
//     log(object);
//   }
//
//   /// Permission.photos: Android：没有,  iOS：相册
//   /// Permission.storage: Android：外部存储,  iOS：访问“文档”或“下载”等文件夹
//   //检查功能权限
//   //mandatory 强制检测
//   static Future<bool> checkPermission(Permission permission, {bool mandatory = false}) async {
//     if (!Platform.isAndroid && mandatory == false) {
//       _log("IOS 不检测权限");
//       return Future.value(true);
//     }
//     _log("${Global.curPlatform} 开始检测${permission.toString()}权限");
//     _log("${permission.toString()}:获取请求状态");
//     var status = await permission.status;
//     if (status.isUndetermined) {
//       log("${permission.toString()}:尚未请求许可");
//       return requestPermission(permission);
//     } else {
//       if (await permission.isPermanentlyDenied) {
//         log("${permission.toString()}:用户选择不再查看该应用程序的权限请求对话框。 现在更改权限状态的唯一方法是让用户在系统设置中手动启用它");
//         permissionDialog(permission);
//         return Future.value(false);
//       } else {
//         return requestPermission(permission);
//       }
//     }
//   }
//
//   //请求功能权限
//   static Future<bool> requestPermission(Permission permission) async {
//     _log("${permission.toString()}:请求权限");
//     await permission.request(); //如果之前尚未授予访问权限，则请求用户访问此[Permission]。
//     _log("${permission.toString()}:获取请求状态");
//     final status = await permission.status;
//     if (status.isGranted) {
//       _log("${permission.toString()}:权限已被许可");
//       return Future.value(true);
//     } else {
//       _log("${permission.toString()}:权限还是不许可");
//       permissionDialog(permission);
//
//       return Future.value(false);
//     }
//   }
//
//   ///前往设置界面
//   static void permissionDialog(Permission permission, {String title = "是否打开设置页面开启权限？"}) {
//     late String tip;
//     if (Permission.location == permission) {
//       tip = "是否打开设置页面开启定位权限？";
//     } else if (Permission.camera == permission) {
//       tip = "是否打开设置页面开启相机权限？";
//     } else if (Permission.microphone == permission) {
//       tip = "是否打开设置页面开启麦克风权限？";
//     } else if (Permission.storage == permission) {
//       tip = "是否打开设置页面开启存储权限？";
//     } else {
//       tip = title;
//     }
//     // DialogUtil.instance().showYNDialog(
//     //   title: tip,
//     //   onTapDetermine: () async {
//     //     openAppSettings();
//     //     log("${permission.toString()}:跳转设置界面");
//     //   },
//     // );
//   }
//
//   //打开权限设置
//   static Future<bool> openAppSetting() async {
//     return openAppSettings();
//   }
// }

/// A Flutter application demonstrating the functionality of this plugin
class PermissionHandlerWidget extends StatefulWidget {
  // /// Create a page containing the functionality of this plugin
  // static ExamplePage createPage() {
  //   return ExamplePage(
  //       Icons.location_on, (context) => PermissionHandlerWidget());
  // }

  @override
  _PermissionHandlerWidgetState createState() => _PermissionHandlerWidgetState();
}

class _PermissionHandlerWidgetState extends State<PermissionHandlerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("权限"),
      ),
      body: Center(
        child: ListView(
            // [
            //   calendar,//日历
            //   camera,//相机
            //   contacts,//联系人
            //   location,//位置
            //   locationAlways,//始终允许
            //   locationWhenInUse,//使用时允许
            //   mediaLibrary,//媒体库
            //   microphone,//麦克风
            //   phone,//联系人
            //   photos,//相册
            //   photosAddOnly,//只读相册
            //   reminders,//提醒
            //   sensors,//传感器
            //   sms,
            //   speech,
            //   storage,//储存
            //   ignoreBatteryOptimizations,
            //   notification,
            //   accessMediaLocation,
            //   activityRecognition,
            //   unknown,
            //   bluetooth,
            //   manageExternalStorage,
            //   systemAlertWindow,
            //   requestInstallPackages,
            //   appTrackingTransparency,
            //   criticalAlerts,
            //   accessNotificationPolicy,
            // ]
            children: Permission.values
                .where((permission) {
                  if (Platform.isIOS) {
                    return permission != Permission.unknown &&
                        permission != Permission.sms &&
                        permission != Permission.storage &&
                        permission != Permission.ignoreBatteryOptimizations &&
                        permission != Permission.accessMediaLocation &&
                        permission != Permission.activityRecognition &&
                        permission != Permission.manageExternalStorage &&
                        permission != Permission.systemAlertWindow &&
                        permission != Permission.requestInstallPackages &&
                        permission != Permission.accessNotificationPolicy;
                  } else {
                    return permission != Permission.unknown &&
                        permission != Permission.mediaLibrary &&
                        permission != Permission.photos &&
                        permission != Permission.photosAddOnly &&
                        permission != Permission.reminders &&
                        permission != Permission.appTrackingTransparency &&
                        permission != Permission.criticalAlerts;
                  }
                })
                .map((permission) => PermissionWidget(permission))
                .toList()),
      ),
    );
  }
}

/// Permission widget containing information about the passed [Permission]
class PermissionWidget extends StatefulWidget {
  /// Constructs a [PermissionWidget] for the supplied [Permission]
  const PermissionWidget(this._permission);

  final Permission _permission;

  @override
  _PermissionState createState() => _PermissionState(_permission);
}

class _PermissionState extends State<PermissionWidget> {
  _PermissionState(this._permission);

  final Permission _permission;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();

    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() async {
    final status = await _permission.status;
    setState(() => _permissionStatus = status);
  }

  Color getPermissionColor() {
    switch (_permissionStatus) {
      case PermissionStatus.denied:
        return Colors.red;
      case PermissionStatus.granted:
        return Colors.green;
      case PermissionStatus.limited:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        _permission.toString(),
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(
        _permissionStatus.toString(),
        style: TextStyle(color: getPermissionColor()),
      ),
      trailing: (_permission is PermissionWithService)
          ? IconButton(
              icon: const Icon(
                Icons.info,
                color: Colors.white,
              ),
              onPressed: () {
                checkServiceStatus(context, _permission as PermissionWithService);
              })
          : null,
      onTap: () {
        requestPermission(_permission);
      },
    );
  }

  void checkServiceStatus(BuildContext context, PermissionWithService permission) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text((await permission.serviceStatus).toString()),
    ));
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();

    setState(() {
      print(status);
      _permissionStatus = status;
      print(_permissionStatus);
    });
  }
}
