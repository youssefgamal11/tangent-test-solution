import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';

class LevelBadge extends StatelessWidget {
  const LevelBadge({super.key, required this.level});

  final String level;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border:
            Border.all(color: AppColors.cyan.withValues(alpha: 0.5), width: 1),
        color: AppColors.cyan.withValues(alpha: 0.08),
      ),
      child: Text(
        level,
        style: AppTextStyle.r10
            .copyWith(color: AppColors.cyan, letterSpacing: 0.5),
      ),
    );
  }
}
