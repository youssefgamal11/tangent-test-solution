import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';

const _relatedWords = ['fleeting', 'transient', 'brief'];

class OnboardingStepFourWidget extends StatelessWidget {
  const OnboardingStepFourWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Deeper insight into\nevery word',
            textAlign: TextAlign.center,
            style: AppTextStyle.sb22,
            
          ),
          SizedBox(height: 32.h),
          Container(
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
            child: Divider(color: AppColors.cyan, thickness: 1)),  
       
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
                style: AppTextStyle.r14.copyWith(color: AppColors.darkGrey, letterSpacing: 1.2),
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
              style: AppTextStyle.r14.copyWith(color: AppColors.darkGrey, letterSpacing: 1.2),
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            children: _relatedWords
                .map(
                  (word) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.slateBlue,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppColors.steelBlue),
                    ),
                    child: Text(
                      word,
                      style: AppTextStyle.r12.copyWith(color: AppColors.grey),
                    ),
                  ),
                )
                .toList(),
          ),
       
              ],
            ),)

           ],
      ),
    );
  }
}
