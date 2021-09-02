
import 'package:flutter_screenutil/flutter_screenutil.dart';

//屏幕统适配
extension SizeExtension on num {
  double get dw => this.w;

  double get dh => this.h;

  double get dsp {
    return this.sp;
  }
}