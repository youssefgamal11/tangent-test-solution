import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/core/utils/img_paths.dart';
import 'package:tangent_test_solution/features/onBoarding/presentation/cubits/cubit.dart';
import 'package:tangent_test_solution/features/onBoarding/presentation/widgets/app_text_form_field.dart';

class OnboardingStepTwoWidget extends StatefulWidget {
  const OnboardingStepTwoWidget({super.key});

  @override
  State<OnboardingStepTwoWidget> createState() =>
      _OnboardingStepTwoWidgetState();
}

class _OnboardingStepTwoWidgetState extends State<OnboardingStepTwoWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
          SizedBox(height: 32.h),
          Text(
            'What should we\ncall you?',
            textAlign: TextAlign.center,
            style: AppTextStyle.sb22,
          ),
          SizedBox(height: 32.h),
          AppTextFormField(
            controller: _controller,
            hintText: 'Your name',
            onChanged: (value) =>
                context.read<OnboardingCubit>().updateUserName(value),
          ),
          SizedBox(height: 12.h),
          Text(
            "We'll personalize your experience",
            style: AppTextStyle.r14.copyWith(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
