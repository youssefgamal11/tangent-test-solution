import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import '../cubits/cubit.dart';
import '../widgets/onboarding_step_four.dart';
import '../widgets/onboarding_step_one.dart';
import '../widgets/onboarding_step_three.dart';
import '../widgets/onboarding_step_two.dart';
import '../widgets/primary_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: state.showSkip ? 1.0 : 0.0,
                    child: TextButton(
                      onPressed: state.showSkip ? cubit.skipToLast : null,
                      child: Text(
                        'Skip',
                        style: AppTextStyle.r16.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: cubit.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: cubit.onPageChanged,
                    children: const [
                      OnboardingStepOneWidget(),
                      OnboardingStepTwoWidget(),
                      OnboardingStepThreeWidget(),
                      OnboardingStepFourWidget(),
                    ],
                  ),
                ),
                PrimaryButton(
                  onPressed: cubit.nextPage,
                  buttonLabel: state.buttonLabel,
                ),
                SizedBox(height: 20.h),
              ],
            );
          },
        ),
      ),
    );
  }
}
