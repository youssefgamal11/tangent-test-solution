import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import '../widgets/onboarding_step_four.dart';
import '../widgets/onboarding_step_one.dart';
import '../widgets/onboarding_step_three.dart';
import '../widgets/onboarding_step_two.dart';
import '../widgets/primary_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<String> _buttonLabels = [
    'Get started',
    'Continue',
    'Continue',
    'Start Learning',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: (_currentPage == 1 || _currentPage == 2) ? 1.0 : 0.0,
                child: TextButton(
                  onPressed: (_currentPage == 1 || _currentPage == 2)
                      ? () => _pageController.jumpToPage(3)
                      : null,
                  child: Text(
                    'Skip',
                    style: AppTextStyle.r16.copyWith(color: AppColors.grey),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: const [
                  OnboardingStepOneWidget(),
                  OnboardingStepTwoWidget(),
                  OnboardingStepThreeWidget(),
                  OnboardingStepFourWidget(),
                ],
              ),
            ),
            PrimaryButton(
              onPressed: () {
                if (_currentPage < 3) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              buttonLabel: _buttonLabels[_currentPage],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
