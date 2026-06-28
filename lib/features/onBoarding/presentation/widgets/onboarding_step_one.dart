import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/core/utils/img_paths.dart';

class OnboardingStepOneWidget extends StatelessWidget {
  const OnboardingStepOneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImgPath.onboardingLogo,
            width: 280.w,
            height: 180.h,
          ),
          SizedBox(height: 40.h),
          Text(
            'Expand your vocabulary\nin 1 minute a day',
            textAlign: TextAlign.center,
            style: AppTextStyle.eb28,
          ),
          SizedBox(height: 12.h),
          Text(
            'One swipe. One word. Every day.',
            textAlign: TextAlign.center,
            style: AppTextStyle.r16.copyWith(color: AppColors.grey, height: 1.5.h),
          ),
          SizedBox(height: 48.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _StatItem(value: '350M+', label: 'Words learned'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                width: 1,
                height: 32.h,
                color: AppColors.steelBlue,
              ),
              const _StatItem(value: '4.0 ★', label: 'App rating'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                width: 1,
                height: 32.h,
                color: AppColors.steelBlue,
              ),
              const _StatItem(value: '1M', label: 'Active learners'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyle.b18.copyWith(color: AppColors.cyan)),
        SizedBox(height: 4.h),
        Text(label, style: AppTextStyle.r10.copyWith(color: AppColors.grey)),
      ],
    );
  }
}
