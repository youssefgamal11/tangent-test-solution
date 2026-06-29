import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/core/utils/img_paths.dart';

import 'animated.dart';

class OnboardingStepOneWidget extends StatefulWidget {
  const OnboardingStepOneWidget({super.key});

  @override
  State<OnboardingStepOneWidget> createState() =>
      _OnboardingStepOneWidgetState();
}

class _OnboardingStepOneWidgetState extends State<OnboardingStepOneWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  late final Animation<double> logoFade, titleFade, subtitleFade, statsFade;
  late final Animation<Offset> logoSlide, titleSlide, subtitleSlide, statsSlide;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    Animation<double> fade(double from, double to) => CurvedAnimation(
          parent: controller,
          curve: Interval(from, to, curve: Curves.easeOut),
        );

    Animation<Offset> slide(double from, double to) =>
        Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(from, to, curve: Curves.easeOut),
          ),
        );

    logoFade = fade(0.0, 0.45);
    logoSlide = slide(0.0, 0.45);

    titleFade = fade(0.2, 0.6);
    titleSlide = slide(0.2, 0.6);

    subtitleFade = fade(0.35, 0.72);
    subtitleSlide = slide(0.35, 0.72);

    statsFade = fade(0.55, 1.0);
    statsSlide = slide(0.55, 1.0);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          animated(
            fade: logoFade,
            slide: logoSlide,
            child: SvgPicture.asset(
              ImgPath.onboardingLogo,
              width: 280.w,
              height: 180.h,
            ),
          ),
          SizedBox(height: 40.h),
          animated(
            fade: titleFade,
            slide: titleSlide,
            child: Text(
              'Expand your vocabulary\nin 1 minute a day',
              textAlign: TextAlign.center,
              style: AppTextStyle.eb28,
            ),
          ),
          SizedBox(height: 12.h),
          animated(
            fade: subtitleFade,
            slide: subtitleSlide,
            child: Text(
              'One swipe. One word. Every day.',
              textAlign: TextAlign.center,
              style:
                  AppTextStyle.r16.copyWith(color: AppColors.grey, height: 1.5.h),
            ),
          ),
          SizedBox(height: 48.h),
          animated(
            fade: statsFade,
            slide: statsSlide,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const StatItem(value: '350M+', label: 'Words learned'),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  width: 1,
                  height: 32.h,
                  color: AppColors.steelBlue,
                ),
                const StatItem(value: '4.0 ★', label: 'App rating'),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  width: 1,
                  height: 32.h,
                  color: AppColors.steelBlue,
                ),
                const StatItem(value: '1M', label: 'Active learners'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  const StatItem({super.key, required this.value, required this.label});

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
