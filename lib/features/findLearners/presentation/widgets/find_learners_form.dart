import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/cubits/cubit.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/cubits/states.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tangent_test_solution/core/utils/img_paths.dart';
import 'package:tangent_test_solution/features/onBoarding/presentation/widgets/app_text_form_field.dart';
import 'package:tangent_test_solution/features/onBoarding/presentation/widgets/primary_button.dart';

class FindLearnersForm extends StatefulWidget {
  const FindLearnersForm({super.key});

  @override
  State<FindLearnersForm> createState() => _FindLearnersFormState();
}

class _FindLearnersFormState extends State<FindLearnersForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final state = context.read<FindLearnersCubit>().state;
    _nameController = TextEditingController(text: state.name);
    _phoneController = TextEditingController(text: state.phoneNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FindLearnersCubit>();
    return BlocListener<FindLearnersCubit, FindLearnersState>(
      listenWhen: (prev, curr) =>
          prev.name != curr.name || prev.phoneNumber != curr.phoneNumber,
      listener: (_, state) {
        if (_nameController.text != state.name) {
          _nameController.text = state.name;
        }
        if (_phoneController.text != state.phoneNumber) {
          _phoneController.text = state.phoneNumber;
        }
      },
      child: BlocBuilder<FindLearnersCubit, FindLearnersState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 32.h),
                SvgPicture.asset(
                  ImgPath.connections,
                  width: 140.w,
                  height: 140.w,
                  colorFilter: ColorFilter.mode(AppColors.cyan, BlendMode.srcIn),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Find learners\nat your level',
                  style: AppTextStyle.eb24,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Connect and practise together',
                  style: AppTextStyle.r13.copyWith(color: AppColors.darkGrey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'YOUR NAME',
                    style: AppTextStyle.r10.copyWith(
                      color: AppColors.grey,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                AppTextFormField(
                  controller: _nameController,
                  hintText: 'YOUR NAME',
                  onChanged: cubit.updateName,
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'PHONE NUMBER',
                    style: AppTextStyle.r10.copyWith(
                      color: AppColors.grey,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                AppTextFormField(
                  controller: _phoneController,
                  hintText: '+20 100 000 0000',
                  keyboardType: TextInputType.phone,
                  onChanged: cubit.updatePhone,
                ),
                SizedBox(height: 24.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: state.agreedToShare,
                      onChanged: (_) => cubit.toggleAgreed(),
                      activeColor: AppColors.indigo,
                      side: BorderSide(color: AppColors.steelBlue, width: 1.5),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: cubit.toggleAgreed,
                        child: Padding(
                          padding: EdgeInsets.only(top: 11.h),
                          child: Text(
                            'I agree to share my info with matched learners',
                            style: AppTextStyle.r14
                                .copyWith(color: AppColors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                AnimatedOpacity(
                  opacity: state.isFormValid ? 1.0 : 0.4,
                  duration: const Duration(milliseconds: 200),
                  child: IgnorePointer(
                    ignoring: !state.isFormValid,
                    child: PrimaryButton(
                      buttonLabel: 'Find Learners',
                      onPressed: cubit.submit,
                      padding: EdgeInsets.only(top: 16.h),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          );
        },
      ),
    );
  }
}
