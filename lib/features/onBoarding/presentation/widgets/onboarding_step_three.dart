import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/features/onBoarding/presentation/cubits/cubit.dart';

const _topics = [
  'Business',
  'Science',
  'Literature',
  'Society',
  'Psychology',
  'Emotions',
  'Technology',
  'Art',
  'Philosophy',
  'History',
];

class OnboardingStepThreeWidget extends StatelessWidget {
  const OnboardingStepThreeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 160.h),
              Text(
                'Which topics\ninterest you?',
                textAlign: TextAlign.center,
                style: AppTextStyle.sb22,
              ),
              SizedBox(height: 10.h),
              Text(
                "Pick as many as you like",
                style: AppTextStyle.r14.copyWith(color: AppColors.grey),
              ),
              SizedBox(height: 20.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                alignment: WrapAlignment.center,
                children: _topics
                    .map(
                      (topic) => _TopicChip(
                        label: topic,
                        isSelected: state.selectedTopics.contains(topic),
                        onTap: () =>
                            context.read<OnboardingCubit>().toggleTopic(topic),
                      ),
                    )
                    .toList(),
              ),
              const Spacer(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: state.selectedTopics.isEmpty
                    ? SizedBox.shrink(key: const ValueKey('empty'))
                    : Text(
                        '${state.selectedTopics.length} selected',
                        key: ValueKey(state.selectedTopics.length),
                        style:
                            AppTextStyle.r12.copyWith(color: AppColors.grey),
                      ),
              ),
              SizedBox(height: 12.h),
            ],
          ),
        );
      },
    );
  }
}

class _TopicChip extends StatelessWidget {
  const _TopicChip({
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
