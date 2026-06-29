import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/features/onBoarding/presentation/cubits/cubit.dart';
import 'animated.dart';

const _relatedWords = ['fleeting', 'transient', 'brief'];

class OnboardingStepFourWidget extends StatefulWidget {
  const OnboardingStepFourWidget({super.key});

  @override
  State<OnboardingStepFourWidget> createState() =>
      _OnboardingStepFourWidgetState();
}

class _OnboardingStepFourWidgetState extends State<OnboardingStepFourWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final PageController pageController;

  late final Animation<double> titleFade, cardFade, cardScale;
  late final Animation<Offset> titleSlide, cardSlide;

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

    titleFade = fade(0.0, 0.45);
    titleSlide = slide(0.0, 0.45);

    cardFade = fade(0.25, 0.75);
    cardSlide = slide(0.25, 0.75);
    cardScale = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.25, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController = context.read<OnboardingCubit>().pageController;
      pageController.addListener(onPageChanged);
    });
  }

  void onPageChanged() {
    if (pageController.page == 3.0 &&
        !controller.isAnimating &&
        controller.value == 0) {
      controller.forward();
    }
  }

  @override
  void dispose() {
    pageController.removeListener(onPageChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          animated(
            fade: titleFade,
            slide: titleSlide,
            child: Text(
              'Deeper insight into\nevery word',
              textAlign: TextAlign.center,
              style: AppTextStyle.sb22,
            ),
          ),
          SizedBox(height: 32.h),
          FadeTransition(
            opacity: cardFade,
            child: SlideTransition(
              position: cardSlide,
              child: ScaleTransition(
                scale: cardScale,
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.slateBlue,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: AppColors.grey, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'ADJECTIVE · PREVIEW',
                          style: AppTextStyle.b11.copyWith(
                            color: AppColors.indigo,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      Text(
                        'ephemeral',
                        style: AppTextStyle.eb36.copyWith(
                          color: AppColors.cyan,
                          fontSize: 42.sp,
                        ),
                      ),
                      SizedBox(
                        width: 80.w,
                        child: Divider(color: AppColors.cyan, thickness: 1),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Lasting for a very short time',
                        style: AppTextStyle.r16.copyWith(color: AppColors.white),
                      ),
                      SizedBox(height: 12.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Example',
                          style: AppTextStyle.r14.copyWith(
                            color: AppColors.darkGrey,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        '"Users describe our app as ephemeral — the extra value it adds fades the moment you stop."',
                        style: AppTextStyle.r14.copyWith(
                          color: AppColors.grey,
                          fontStyle: FontStyle.italic,
                          height: 1.6,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Synonyms',
                          style: AppTextStyle.r14.copyWith(
                            color: AppColors.darkGrey,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Wrap(
                        spacing: 8.w,
                        children: _relatedWords
                            .map(
                              (word) => Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.slateBlue,
                                  borderRadius: BorderRadius.circular(20.r),
                                  border:
                                      Border.all(color: AppColors.steelBlue),
                                ),
                                child: Text(
                                  word,
                                  style: AppTextStyle.r12
                                      .copyWith(color: AppColors.grey),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
