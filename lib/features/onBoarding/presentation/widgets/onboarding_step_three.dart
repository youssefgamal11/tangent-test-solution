import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/features/onBoarding/presentation/cubits/cubit.dart';
import 'package:tangent_test_solution/features/shared/data/topics_data.dart';
import 'animated.dart';

class OnboardingStepThreeWidget extends StatefulWidget {
  const OnboardingStepThreeWidget({super.key});

  @override
  State<OnboardingStepThreeWidget> createState() =>
      _OnboardingStepThreeWidgetState();
}

class _OnboardingStepThreeWidgetState extends State<OnboardingStepThreeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final PageController pageController;

  late final Animation<double> titleFade, subtitleFade, chipsFade;
  late final Animation<Offset> titleSlide, subtitleSlide, chipsSlide;

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

    subtitleFade = fade(0.2, 0.6);
    subtitleSlide = slide(0.2, 0.6);

    chipsFade = fade(0.38, 1.0);
    chipsSlide = slide(0.38, 1.0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController = context.read<OnboardingCubit>().pageController;
      pageController.addListener(onPageChanged);
    });
  }

  void onPageChanged() {
    if (pageController.page == 2.0 &&
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 160.h),
          animated(
            fade: titleFade,
            slide: titleSlide,
            child: Text(
              'Which topics\ninterest you?',
              textAlign: TextAlign.center,
              style: AppTextStyle.sb22,
            ),
          ),
          SizedBox(height: 10.h),
          animated(
            fade: subtitleFade,
            slide: subtitleSlide,
            child: Text(
              'Pick as many as you like',
              style: AppTextStyle.r14.copyWith(color: AppColors.grey),
            ),
          ),
          SizedBox(height: 20.h),
          animated(
            fade: chipsFade,
            slide: chipsSlide,
            child: BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                return Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  alignment: WrapAlignment.center,
                  children: topics
                      .map(
                        (topic) => TopicChip(
                          label: topic,
                          isSelected: state.selectedTopics.contains(topic),
                          onTap: () => context
                              .read<OnboardingCubit>()
                              .toggleTopic(topic),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
          const Spacer(),
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: state.selectedTopics.isEmpty
                    ? SizedBox.shrink(key: const ValueKey('empty'))
                    : Text(
                        '${state.selectedTopics.length} selected',
                        key: ValueKey(state.selectedTopics.length),
                        style: AppTextStyle.r12.copyWith(color: AppColors.grey),
                      ),
              );
            },
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}

class TopicChip extends StatelessWidget {
  const TopicChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.indigo : AppColors.slateBlue,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isSelected ? AppColors.indigo : AppColors.steelBlue,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyle.m14.copyWith(
            color: isSelected ? AppColors.white : AppColors.grey,
          ),
        ),
      ),
    );
  }
}
