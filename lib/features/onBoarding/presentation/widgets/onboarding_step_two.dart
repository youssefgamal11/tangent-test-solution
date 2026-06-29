import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/core/utils/img_paths.dart';
import 'package:tangent_test_solution/features/onBoarding/presentation/cubits/cubit.dart';
import 'package:tangent_test_solution/features/onBoarding/presentation/widgets/app_text_form_field.dart';

import 'animated.dart';

class OnboardingStepTwoWidget extends StatefulWidget {
  const OnboardingStepTwoWidget({super.key});

  @override
  State<OnboardingStepTwoWidget> createState() =>
      _OnboardingStepTwoWidgetState();
}

class _OnboardingStepTwoWidgetState extends State<OnboardingStepTwoWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController textController = TextEditingController();
  late final AnimationController controller;
  late final PageController pageController;

  late final Animation<double> avatarFade, avatarScale;
  late final Animation<double> titleFade, fieldFade, hintFade;
  late final Animation<Offset> titleSlide, fieldSlide, hintSlide;

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

    avatarFade = fade(0.0, 0.45);
    avatarScale = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOutBack),
      ),
    );

    titleFade = fade(0.2, 0.6);
    titleSlide = slide(0.2, 0.6);

    fieldFade = fade(0.38, 0.75);
    fieldSlide = slide(0.38, 0.75);

    hintFade = fade(0.55, 1.0);
    hintSlide = slide(0.55, 1.0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController = context.read<OnboardingCubit>().pageController;
      pageController.addListener(onPageChanged);
    });
  }

  void onPageChanged() {
    if ((pageController.page ?? 0) >= 0.85 &&
        !controller.isAnimating &&
        controller.value == 0) {
      controller.forward();
    }
  }

  @override
  void dispose() {
    pageController.removeListener(onPageChanged);
    textController.dispose();
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
          FadeTransition(
            opacity: avatarFade,
            child: ScaleTransition(
              scale: avatarScale,
              child: Container(
                width: 88.w,
                height: 88.w,
                decoration: BoxDecoration(
                  color: AppColors.slateBlue,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.indigo, width: 1.5),
                ),
                child: SvgPicture.asset(
                  ImgPath.person,
                  width: 44.w,
                  height: 44.w,
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h),
          animated(
            fade: titleFade,
            slide: titleSlide,
            child: Text(
              'What should we\ncall you?',
              textAlign: TextAlign.center,
              style: AppTextStyle.sb22,
            ),
          ),
          SizedBox(height: 32.h),
          animated(
            fade: fieldFade,
            slide: fieldSlide,
            child: AppTextFormField(
              controller: textController,
              hintText: 'Your name',
              onChanged: (value) =>
                  context.read<OnboardingCubit>().updateUserName(value),
            ),
          ),
          SizedBox(height: 12.h),
          animated(
            fade: hintFade,
            slide: hintSlide,
            child: Text(
              "We'll personalize your experience",
              style: AppTextStyle.r14.copyWith(color: AppColors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
