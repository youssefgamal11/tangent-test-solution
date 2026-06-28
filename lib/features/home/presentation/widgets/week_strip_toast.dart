import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/core/utils/img_paths.dart';
import 'package:tangent_test_solution/features/home/presentation/widgets/week_strip.dart';

class WeekStripToast extends StatelessWidget {
  const WeekStripToast({
    super.key,
    required this.streak,
    required this.weeklyProgress,
  });

  final int streak;
  final List<bool> weeklyProgress;

  static void show(
    BuildContext context, {
    required int streak,
    required List<bool> weeklyProgress,
  }) {
    final overlay = OverlayEntry(
      builder: (_) => WeekStripToast(
        streak: streak,
        weeklyProgress: weeklyProgress,
      ),
    );
    Overlay.of(context).insert(overlay);
    Future.delayed(const Duration(seconds: 3), overlay.remove);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60.h,
      left: 24.w,
      right: 24.w,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.slateBlue,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.steelBlue, width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Lottie.asset(
                    ImgPath.flameAnimation,
                    width: 52.w,
                    height: 52.w,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Day $streak streak!',
                    style: AppTextStyle.b18.copyWith(color: AppColors.coral),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              WeekStrip(weeklyProgress: weeklyProgress),
            ],
          ),
        ),
      ),
    );
  }
}
