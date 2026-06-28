import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';

class AppTextStyle {
  static const fontFamily = 'Inter';
  static const playfairFamily = 'PlayfairDisplaySC';

  static TextStyle r10  = TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, fontFamily: fontFamily, color: AppColors.white, height: 1);
  static TextStyle r12  = TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, fontFamily: fontFamily, color: AppColors.white, height: 1);
  static TextStyle r14  = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, fontFamily: fontFamily, color: AppColors.white, height: 1);
  static TextStyle r16  = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, fontFamily: fontFamily, color: AppColors.white, height: 1);

  static TextStyle m14  = TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, fontFamily: fontFamily, color: AppColors.white, height: 1);

  static TextStyle sb22 = TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600, fontFamily: playfairFamily, color: AppColors.white, height: 1.3);

  static TextStyle b11  = TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w700, fontFamily: fontFamily,     color: AppColors.white, height: 1);
  static TextStyle b18  = TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700, fontFamily: fontFamily,     color: AppColors.white, height: 1);

  
  static TextStyle eb16 = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800, fontFamily: fontFamily,     color: AppColors.white, height: 1);
  static TextStyle eb28 = TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w800, fontFamily: playfairFamily, color: AppColors.white, height: 1.3);
  static TextStyle eb36 = TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w800, fontFamily: playfairFamily, color: AppColors.white, height: 1.2);
}
