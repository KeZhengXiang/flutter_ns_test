// import 'package:dio/dio.dart';
// import 'package:dio_http_formatter/dio_http_formatter.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_ns_test/http/api_url.dart';
// import 'package:flutter_ns_test/http/code.dart';
// import 'package:flutter_ns_test/http/http_tool.dart';
// import 'package:flutter_ns_test/tool/log_utils.dart';
//
// /// 使用 File api
// import 'dart:io';
//
// /// 使用 Uint8List 数据类型
// import 'dart:typed_data';
//
// /// 授权管理
// import 'date_util.dart';
//
// //图片选择及上传（图片操作）
// class ImageUtil { // static _instance，_instance会在编译期被初始化，保证了只被创建一次
//   static final ImageUtil _instance = ImageUtil._internal();
//
//   //提供了一个工厂方法来获取该类的实例
//   factory ImageUtil(){
//     return _instance;
//   }
//
//   ImageUtil._internal(){
//     // 初始化
//     init();
//   }
//
//   final Dio _dio = Dio();
//
//   static int uploadLimitSize = 2 * 1024;
//
//   void init() {
//     _dio.options = HttpTool.instance.dio.options;
//     _dio.interceptors.add(HttpFormatter());
//   }
//
//   //图片压缩
//   Future<Uint8List> myFlutterNativeImage(String path, {int quality}) async {
//     ImageProperties properties = await FlutterNativeImage.getImageProperties(path);
//     File compressedFile = await FlutterNativeImage.compressImage(path,
//         quality: quality == null ? 70 : quality,
//         targetWidth: properties.width,
//         targetHeight: properties.height);
//     return compressedFile.readAsBytes();
//   }
//
//   ///选择照片
//   Future<List<Asset>> loadAssets() async {
//     List<Asset> resultList;
//     String error;
//     try {
//       resultList = await MultiImagePicker.pickImages(
//         // 选择图片的最大数量
//         maxImages: 9,
//         // 是否支持拍照
//         enableCamera: true,
//         materialOptions: MaterialOptions(
//             // 显示所有照片，值为 false 时显示相册
//             startInAllView: true,
//             allViewTitle: '所有照片',
//             actionBarColor: '#2196F3',
//             textOnNothingSelected: '没有选择照片'),
//       );
//     } on Exception catch (e) {
//       error = e.toString();
//       log("选择图片出错： error = $error");
//     }
//
//     if (resultList == null || resultList.length <= 0) {
//       log("没有选择照片");
//       return null;
//     }
//     return Future.value(resultList);
//   }
//
//   ///
//   Future<Uint8List> assetToUint8List(Asset asset, {int uploadLimitSize = 2 * 1024}) async {
//     return compressionToTargetImg(asset, uploadLimitSize);
//     // // 获取 ByteData
//     // ByteData byteData = await asset.getByteData();
//     // Uint8List imageData = byteData.buffer.asUint8List();
//     // var dataSize = imageData.length / 1024;
//     // log("上传图片源大小: $dataSize KB");
//     // Uint8List targetData;
//     // if (dataSize >= uploadLimitSize) {
//     //   // ToastUtil.showToast(msg: "上传图片超过大小");
//     //   // return null;
//     //
//     //   ///压缩  requestOriginal getByteData
//     //   var newByteData = await asset.getByteData(quality: 70);
//     //   Uint8List newImageData = newByteData.buffer.asUint8List();
//     //   var byteZipSize = newImageData.length / 1024;
//     //   log("上传图片压缩后大小: $byteZipSize KB");
//     //   targetData = newImageData;
//     // } else {
//     //   targetData = imageData;
//     // }
//     // return targetData;
//   }
//
//   ///压缩图片Asset至目标大小以内
//   ///  * [asset] - 图片资产
//   ///  * [uploadLimitSize] - 小于此大小
//   ///return - Uint8List
//   Future<Uint8List> compressionToTargetImg(Asset asset, int uploadLimitSize) async {
//     //压缩次数
//     int count = 1;
//     Uint8List targetData;
//
//     // 获取 ByteData
//     ByteData byteData = await asset.getByteData();
//     if (byteData == null) {
//       return null;
//     }
//     Uint8List imageData = byteData.buffer.asUint8List();
//
//     double dataSize = imageData.length / 1024;
//     log("上传图片源大小: $dataSize KB, 限制：$uploadLimitSize");
//
//     //最新大小
//     double byteZipSize = dataSize;
//
//     do {
//       // var quality = 70 - ((count - 1) * 5);
//       // if (dataSize > 15000) {
//       //   quality = 48 - ((count - 1) * 5);
//       // } else if (dataSize > 10000) {
//       //   quality = 58 - ((count - 1) * 5);
//       // } else {
//       //   quality = 70 - ((count - 1) * 5);
//       // }
//       ///压缩  requestOriginal getByteData
//       var newByteData = await asset.getThumbByteData(540, 960, quality: 100 - ((count - 1) * 5));
//       // var newByteData = await asset.getByteData(quality: quality);
//       targetData = newByteData.buffer.asUint8List();
//       byteZipSize = targetData.length / 1024;
//       log("第$count次压缩【end】， 压缩后图片大小: $byteZipSize KB");
//       count = count + 1;
//     } while (byteZipSize >= uploadLimitSize);
//     return targetData;
//   }
//
//   ///上传图片组
//   void upLoadImages(List<Asset> assets,
//       {int uploadLimitSize = 2 * 1024, Function(List<String>) successCall}) async {
//     List<String> imageUrlList = [];
//     int count = assets.length;
//     // 上传照片时一张一张上传
//     for (int i = 0; i < assets.length; i++) {
//       var data = await assetToUint8List(assets[i], uploadLimitSize: uploadLimitSize);
//       upLoadImage(data, index: i, url: ApiUrl.upLoadCover).then((imageUrl) {
//         count--;
//         if (imageUrl != null && imageUrl.isEmpty) {
//           log("index = $i, 上传图片成功 +1, imageUrl = $imageUrl, count = $count");
//           if (count <= 0) {
//             successCall(imageUrlList);
//           }
//         } else {
//           log("index = $i, 上传图片失败 +1, count = $count");
//           if (count <= 0) {
//             successCall(imageUrlList);
//           }
//         }
//       });
//     }
//   }
//
//   ///上传单张图片
//   Future<String> upLoadImage(Uint8List imageData,
//       {String formDataKey = "file",
//       int index = 0,
//       String url,
//       int uploadLimitSize = 2 * 1024}) async {
//     if (imageData == null) {
//       return null;
//     }
//
//     ///设置表单
//     MultipartFile multipartFile = MultipartFile.fromBytes(
//       imageData,
//       // 文件名
//       filename: '${DateUtil.getCurTimeStamp()}_cover.png',
//       // 文件类型
//       //  contentType: MediaType("image", "png"),
//     );
//
//     ///参数
//     FormData formData = FormData.fromMap({
//       formDataKey: multipartFile,
//       "filetype": "image",
//     });
//     // 后端接口 url
//     String httpUrl = ApiUrl.baseUrl + url;
//     String imageUrl;
//     // 使用 dio 上传图片
//     try {
//       var response = await _dio.post(
//         httpUrl,
//         data: formData,
//       );
//       // log(response);
//       var map = response.data as Map;
//       if (map["code"] == HttpCode.SUCCESS && map["code"] != null) {
//         var md = UpImgModel.fromJson(response.data["data"]);
//         imageUrl = md.showReadytoauditurl;
//         log("index = $index, 上传图片成功 +1, imageUrl = $imageUrl");
//       } else if (map["code"] == 0) {
//         if (map["message"] is String) {
//           var str = map["message"];
//           ToastUtil.showToast(msg: str);
//         }
//       }
//       return imageUrl;
//     } on DioError catch (e) {
//       log("index = $index, 上传图片出错 +1, \nerr:[$e]");
//       return imageUrl;
//     }
//   }
//
//   ///上传单张图片
//   Future<String> upLoadImage2(Uint8List imageData,
//       {String formDataKey = "header",
//       int index = 0,
//       String url,
//       int uploadLimitSize = 4 * 1024}) async {
//     if (imageData == null) {
//       return null;
//     }
//
//     ///设置表单
//     MultipartFile multipartFile = MultipartFile.fromBytes(
//       imageData,
//       // 文件名
//       filename: '${DateUtil.getCurTimeStamp()}_cover.png',
//       // 文件类型
//       //  contentType: MediaType("image", "png"),
//     );
//
//     ///参数
//     FormData formData = FormData.fromMap({
//       formDataKey: multipartFile,
//       // "filetype": "image",
//     });
//     // 后端接口 url
//     String httpUrl = ApiUrl.baseUrl + url;
//     String imageUrl;
//     // 使用 dio 上传图片
//     try {
//       var response = await _dio.post(
//         httpUrl,
//         data: formData,
//       );
//       // log(response);
//       var map = response.data as Map;
//       if (map["code"] == HttpCode.SUCCESS && map["code"] != null) {
//         imageUrl = response.data["data"]['url'];
//
//         log("index = $index, 上传图片成功 +1, imageUrl = $imageUrl");
//       }
//       return imageUrl;
//     } on DioError catch (e) {
//       log("index = $index, 上传图片出错 +1, \nerr:[$e]");
//       return imageUrl;
//     }
//   }
//
//   ///上传数据
//   void onSendProgress(int count, int total) {
//     log("上传图片进度: total = $total, count = $count");
//   }
//
//   //***************  保存图片到本地相册 begin ***************
//
//   /// 保存图片到相册
//   static Future<bool> saveImage(Uint8List imageBytes) async {
//     try {
//       if (imageBytes == null) {
//         log('保存失败，图片不存在！');
//         return Future.value(false);
//       }
//       if (Platform.isAndroid) {
//         ///存储权限检测
//         if (await PermissionUtil.checkPermission(Permission.storage)) {
//           /// 保存图片
//           final result = await ImageGallerySaver.saveImage(imageBytes);
//           if (!(result == null || result == '')) {
//             return Future.value(true);
//           }
//         }
//       } else if (Platform.isIOS) {
//         if (await GF.saveImage(imageBytes)) {
//           return Future.value(true);
//         } else {
//           PermissionUtil.permissionDialog(Permission.photos);
//         }
//       }
//       return Future.value(false);
//     } catch (e) {
//       log("相册权限检测报错: ${e.toString()}");
//       return Future.value(false);
//     }
//   }
//
//   /// 保存网络图片到相册
//   ///
//   /// 默认为下载网络图片，如需下载资源图片，需要指定 [isAsset] 为 `true`。
// //  static Future<void> saveNetImage(String imageUrl, {bool isAsset: false}) async {
// //    try {
// //      if (imageUrl == null) throw '保存失败，图片不存在！';
// //
// //      /// 权限检测
// //      PermissionStatus storageStatus = await Permission.storage.status;
// //      if (storageStatus != PermissionStatus.granted) {
// //        storageStatus = await Permission.storage.request();
// //        if (storageStatus != PermissionStatus.granted) {
// //          throw '无法存储图片，请先授权！';
// //        }
// //      }
// //
// //      /// 保存的图片数据
// //      Uint8List imageBytes;
// //
// //      if (isAsset == true) {
// //        /// 保存资源图片
// //        ByteData bytes = await rootBundle.load(imageUrl);
// //        imageBytes = bytes.buffer.asUint8List();
// //      } else {
// //        /// 保存网络图片
// //        CachedNetworkImage image = CachedNetworkImage(imageUrl: imageUrl);
// //        DefaultCacheManager manager = image.cacheManager ?? DefaultCacheManager();
// //        Map<String, String> headers = image.httpHeaders;
// //        File file = await manager.getSingleFile(
// //          image.imageUrl,
// //          headers: headers,
// //        );
// //        imageBytes = await file.readAsBytes();
// //      }
// //
// //      /// 保存图片
// //      final result = await ImageGallerySaver.saveImage(imageBytes);
// //
// //      if (result == null || result == '') throw '图片保存失败';
// //
// //      print("保存成功");
// //    } catch (e) {
// //      print(e.toString());
// //    }
// //  }
//
// //***************  保存图片到本地相册 end ***************
// }