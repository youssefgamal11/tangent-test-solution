import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';

class WeekStrip extends StatelessWidget {
  const WeekStrip({super.key, required this.weeklyProgress});

  final List<bool> weeklyProgress;

  static const _dayLabels = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  @override
  Widget build(BuildContext context) {
    final todayIndex = DateTime.now().weekday - 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(7, (i) {
          final isToday = i == todayIndex;
          final isCompleted = i < weeklyProgress.length && weeklyProgress[i];
          return _DayCircle(
            label: _dayLabels[i],
            isToday: isToday,
            isCompleted: isCompleted,
          );
        }),
      ),
    );
  }
}

class _DayCircle extends StatelessWidget {
  const _DayCircle({
    required this.label,
    required this.isToday,
    required this.isCompleted,
  });

  final String label;
  final bool isToday;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppTextStyle.r10.copyWith(
            color: isToday ? AppColors.white : AppColors.grey,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? AppColors.coral : AppColors.slateBlue,
            border: Border.all(
              color: isToday
                  ? AppColors.grey
                  : isCompleted
                      ? AppColors.white
                      : AppColors.steelBlue,
              width: 1.5,
            ),
          ),
          child: isCompleted
              ? Icon(Icons.check_rounded, color: AppColors.white, size: 16.sp)
              : null,
        ),
      ],
    );
  }
}
