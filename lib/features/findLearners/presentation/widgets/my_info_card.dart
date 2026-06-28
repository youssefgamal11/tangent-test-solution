import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/widgets/level_badge.dart';

class MyInfoCard extends StatelessWidget {
  const MyInfoCard({
    super.key,
    required this.name,
    required this.phone,
    required this.level,
    this.onEdit,
  });

  final String name;
  final String phone;
  final String level;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.slateBlue,
        borderRadius: BorderRadius.circular(16.r),
        border:
            Border.all(color: AppColors.cyan.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: AppTextStyle.b14),
                    SizedBox(width: 8.w),
                    LevelBadge(level: level),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  phone,
                  style: AppTextStyle.r12.copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ),
          if (onEdit != null)
            GestureDetector(
              onTap: onEdit,
              child: Text(
                'Edit',
                style: AppTextStyle.r12.copyWith(color: AppColors.indigo),
              ),
            ),
        ],
      ),
    );
  }
}
