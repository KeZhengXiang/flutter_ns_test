import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'log_utils.dart';
import 'toast_util.dart';

//iOS沙盒文件目录介绍: https://www.jianshu.com/p/133de925fdb4
class PathUtil {
  static final PathUtil _instance = PathUtil._internal();

  factory PathUtil() {
    return _instance;
  }

  PathUtil._internal() {
    init();
  }

  //=======================================性感的分割线=========================================

  void init() {}

  void test() async {
    // logDebug("             temporaryPath：" + (await temporaryDirectory).path);
    // logDebug("    applicationSupportPath：" + (await applicationSupportDirectory).path);
    // logDebug("               libraryPath：" + (await libraryDirectory).path);
    // logDebug("  applicationDocumentsPath：" + (await applicationDocumentsDirectory).path);

    clearCache();
    // listDir(await temporaryDirectory);

    // final tem = await temporaryDirectory;
    // // final tem = Directory((await temporaryDirectory).path + "/BetterPlayerCache");
    // dirSize(tem);
    // listDir(tem);
  }

  //=======================================性感的分割线=========================================

  /// 清理缓存
  void clearCache() async {
    Directory tempDir = await temporaryDirectory;
    final size = await dirSize(tempDir);
    //删除缓存目录
    await deleteDir(tempDir);

    logDebug("清除缓存成功 $size");
    ToastUtil.showToast(msg: "清除缓存成功 $size");
  }

  //=======================================性感的分割线=========================================

  ///目录大小
  Future<String> dirSize(Directory dir) async {
    double size = await _getTotalSizeOfFilesInDir(dir);
    final sizeStr = renderSize(size);
    print(dir.path + ':目录大小' + sizeStr);
    return sizeStr;
  }

  ///列出[dir]的子目录和文件。
  void listDir(Directory dir) {
    logDebug("列出目录:${dir.path}");
    dir.list(followLinks: true, recursive: true).listen((file) {
      logDebug(file.path);
    });
  }

  /// 循环计算文件\文件夹大小（递归）
  /// * - [file] 文件或文件夹
  /// return 字节大小
  Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return length.toDouble();
    } else if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;

      for (final FileSystemEntity child in children)
        total += await _getTotalSizeOfFilesInDir(child);
      return total;
    }
    return 0;
  }

  /// 渲染字节数
  /// * - [size] 字节
  String renderSize(double size) {
    if (size == 0) {
      return '0M';
    }
    List<String> unitArr = ["B", "K", "M", "G", "T"];
    int index = 0;
    while (size > 1024) {
      index++;
      size = size / 1024;
    }
    String sizeStr = size.toStringAsFixed(2);
    return sizeStr + unitArr[index];
  }

  /// 递归方式删除目录
  /// * - [file] 文件或文件夹
  Future<Null> deleteDir(FileSystemEntity file, {bool isTop = true}) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await deleteDir(child, isTop: false);
      }
    }

    if (Platform.isIOS) {
      if (file is File) {
        await file.delete();
        logDebug("IOS delete file: ${file.path}");
      } else {
        if (!isTop) {
          await file.delete();
          logDebug("IOS delete folder: ${file.path}");
        } else
          logDebug("IOS 保留 folder: ${file.path}");
      }
    } else {
      if (file is File) {
        await file.delete();
        logDebug("Android delete file: ${file.path}");
      } else {
        if (!isTop) {
          await file.delete();
          logDebug("Android delete folder: ${file.path}");
        } else
          logDebug("Android 保留 folder: ${file.path}");
      }
    }
  }

  //=======================================性感的分割线=========================================
  Directory? _temporaryDirectory;
  Directory? _applicationSupportDirectory;
  Directory? _libraryDirectory;
  Directory? _applicationDocumentsDirectory;

  ///【Android IOS】 临时缓存目录
  Future<Directory> get temporaryDirectory async {
    if (_temporaryDirectory == null) {
      Directory dir = await getTemporaryDirectory();
      // logDebug("path:" + dir.path);
      _temporaryDirectory = dir;
      return dir;
    } else {
      return _temporaryDirectory!;
    }
  }

  ///【Android IOS】 应用程序支持目录。建议用来存储除用户数据相关以外的所有文件。
  Future<Directory> get applicationSupportDirectory async {
    if (_applicationSupportDirectory == null) {
      Directory dir = await getApplicationSupportDirectory();
      // logDebug("path:" + dir.path);
      _applicationSupportDirectory = dir;
      return dir;
    } else {
      return _applicationSupportDirectory!;
    }
  }

  ///【Android IOS】 应用程序可以存储持久文件的目录路径
  /// 不建议在该目录下保存任何用户相关数据，而是保存APP运行需要的修改数据，当然用户可以根据自己的实际需要进行保存。
  Future<Directory> get libraryDirectory async {
    if (_libraryDirectory == null) {
      Directory dir = await getLibraryDirectory();
      // logDebug("path:" + dir.path);
      _libraryDirectory = dir;
      return dir;
    } else {
      return _libraryDirectory!;
    }
  }

  ///【Android IOS】用户数据目录。保存用户创建的文档文件等的目录。建议保存你希望用户看得见的文件。
  Future<Directory> get applicationDocumentsDirectory async {
    if (_applicationDocumentsDirectory == null) {
      Directory dir = await getApplicationDocumentsDirectory();
      // logDebug("path:" + dir.path);
      _applicationDocumentsDirectory = dir;
      return dir;
    } else {
      return _applicationDocumentsDirectory!;
    }
  }

  ///【Android】 应用程序可以访问顶级存储的目录的路径
  Future<Directory?> get externalStorageDirectory async {
    if (Platform.isAndroid) {
      Directory dir = (await getExternalStorageDirectory())!;
      return dir;
    } else {
      logDebug("属于Android 顶级目录，IOS 不存在此目录");
    }
    return null;
  }

  ///【Android】 应用程序特定的外部缓存数据所在目录的路径存储。这些路径通常独立地驻留在外部存储中分区或SD卡。手机可能有多个存储目录可用。
  Future<List<Directory>?> get externalCacheDirectories async {
    if (Platform.isAndroid) {
      List<Directory> dirs = (await getExternalCacheDirectories())!;
      return dirs;
    } else {
      logDebug("属于Android 顶级目录，IOS 不存在此目录");
    }
    return null;
  }

  ///【Android】 可以存储应用程序特定数据的目录的路径。这些路径通常驻留在外部存储中，就像单独的分区一样或者SD卡。手机可能有多个可用的存储目录。
  Future<List<Directory>?> get externalStorageDirectories async {
    if (Platform.isAndroid) {
      List<Directory> dirs = (await getExternalStorageDirectories())!;
      return dirs;
    } else {
      logDebug("属于Android 顶级目录，IOS 不存在此目录");
    }
    return null;
  }

  ///【桌面系统】 下载文件存放目录的路径。这通常只与桌面操作系统相关。
  Future<Directory?> get downloadsDirectory async {
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      Directory dir = (await getDownloadsDirectory())!;
      return dir;
    } else {
      logDebug("此目录属于桌面系统下载目录");
    }
    return null;
  }
}
