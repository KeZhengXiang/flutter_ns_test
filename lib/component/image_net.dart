import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//网络图片统一使用这个组件
class DImageNet extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double radius;
  final PlaceholderWidgetBuilder? placeholder;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;
  final LoadingErrorWidgetBuilder? errorWidget;

  /// Will resize the image in memory to have a certain width using [ResizeImage]
  /// 将调整图像在内存中有一个特定的宽度使用[ResizeImage]
  final int? memCacheWidth;
  final int? memCacheHeight;

  /// 将调整图像的大小并将调整后的图像存储在磁盘缓存中。
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;

  final String? cacheKey;
  final FilterQuality filterQuality;
  final BlendMode? colorBlendMode;

  //压缩后缀
  final String joinUrl;

  //进场动画时长
  final Duration fadeInDuration;

  const DImageNet(this.imageUrl,
      {Key? key,
      this.width,
      this.height,
      this.fit = BoxFit.contain,
      this.radius = 0,
      this.placeholder,
      this.progressIndicatorBuilder,
      this.errorWidget,
      this.memCacheWidth,
      this.memCacheHeight,
      this.maxWidthDiskCache,
      this.maxHeightDiskCache,
      this.joinUrl = "",
      this.filterQuality = FilterQuality.low,
      this.colorBlendMode,
      this.cacheKey,
      this.fadeInDuration = const Duration(milliseconds: 200)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final img = CachedNetworkImage(
      fadeOutDuration: const Duration(milliseconds: 200),
      fadeInDuration: fadeInDuration,
      width: width,
      height: height,
      cacheKey: cacheKey,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      maxWidthDiskCache: maxWidthDiskCache,
      maxHeightDiskCache: maxHeightDiskCache,
      filterQuality: filterQuality,
      imageUrl: imageUrl + joinUrl,
      colorBlendMode: colorBlendMode,
      fit: fit,
      placeholder: placeholder ??
          (context, url) {
            return Container(
              color: Theme.of(context).primaryColor, // 底色
              width: width,
              height: height,
            );
          },
      errorWidget: errorWidget ??
          (context, url, error) {
            return Container(
              color: Colors.grey, // 底色
              width: double.infinity,
              height: double.infinity,
              // child: Icon(Icons.error),
            );
          },
    );
    if (radius == 0) {
      return img;
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: img,
      );
    }
  }
}
