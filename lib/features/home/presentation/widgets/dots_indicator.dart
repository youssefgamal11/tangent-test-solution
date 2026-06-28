import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({super.key, required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: isActive ? 20.w : 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: isActive ? AppColors.indigo : AppColors.steelBlue,
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}
