import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/features/home/presentation/cubits/cubit.dart';

class WordSwipeCard extends StatelessWidget {
  const WordSwipeCard({
    super.key,
    required this.card,
    required this.index,
    required this.pageController,
  });

  final WordCard card;
  final int index;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: pageController,
          builder: (context, _) {
            double offset = index.toDouble();
            if (pageController.hasClients && pageController.page != null) {
              offset = index - pageController.page!;
            }
            offset = offset.clamp(-1.0, 1.0);

            final isActive = offset.abs() < 0.5;
            final scale = 1.0 - (offset.abs() * 0.13);

            return OverflowBox(
              maxHeight: double.infinity,
              child: Transform.scale(
                scale: scale,
                child: Container(
                  height: constraints.maxHeight * 0.5,
                  margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 40.h),
                  decoration: BoxDecoration(
                    color: AppColors.darkBlue,
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(
                      color: AppColors.cyan,
                      width: isActive ? 1.5 : 1.0,
                    ),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: AppColors.cyan.withValues(alpha: 0.55),
                              blurRadius: 32,
                              spreadRadius: 4,
                            ),
                            BoxShadow(
                              color: AppColors.cyan.withValues(alpha: 0.2),
                              blurRadius: 64,
                              spreadRadius: 12,
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: AppColors.cyan.withValues(alpha: 0.1),
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                          ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            card.partOfSpeech.toUpperCase(),
                            style: AppTextStyle.b11.copyWith(
                              color: AppColors.indigo,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            card.word.toLowerCase(),
                            style: AppTextStyle.eb36.copyWith(color: AppColors.cyan),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            card.definition,
                            style: AppTextStyle.r16.copyWith(height: 1.6),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
