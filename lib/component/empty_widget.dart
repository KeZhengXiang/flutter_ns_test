import 'package:flutter/material.dart';
import 'package:flutter_ns_test/resources/image_path.dart';
import 'package:flutter_ns_test/extension/size_extension.dart';

//空视图
class EmptyWidget extends StatelessWidget {
  final double? imageWidth;
  final double? imageHeight;
  final Color? color;

  EmptyWidget({Key? key, this.imageHeight, this.imageWidth, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: color ?? Colors.transparent,
      child: Center(
        child: Image.asset(
          ImagePath.nullImage,
          width: imageWidth ?? 90.dw,
          height: imageHeight ?? 90.dw,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
