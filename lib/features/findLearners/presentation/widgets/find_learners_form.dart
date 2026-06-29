import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tangent_test_solution/core/storage/storage_service.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/core/utils/img_paths.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/cubits/cubit.dart';
import 'package:tangent_test_solution/features/onBoarding/presentation/widgets/app_text_form_field.dart';
import 'package:tangent_test_solution/features/onBoarding/presentation/widgets/primary_button.dart';

class FindLearnersForm extends StatefulWidget {
  const FindLearnersForm({super.key});

  @override
  State<FindLearnersForm> createState() => _FindLearnersFormState();
}

class _FindLearnersFormState extends State<FindLearnersForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  final agreedToShare = ValueNotifier<bool>(false);

  bool get isValid =>
      nameController.text.trim().isNotEmpty &&
      phoneController.text.trim().isNotEmpty &&
      agreedToShare.value;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final name = await StorageService.getUserName() ?? '';
    final phone = await StorageService.getUserPhone() ?? '';
    nameController.text = name;
    phoneController.text = phone;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    agreedToShare.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FindLearnersCubit>();
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
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
              controller: nameController,
              hintText: 'your name',
              
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
              controller: phoneController,
              hintText: '+20 100 000 0000',
              keyboardType: TextInputType.phone,
             
            ),
            SizedBox(height: 24.h),
            ValueListenableBuilder<bool>(
              valueListenable: agreedToShare,
              builder: (_, agreed, _) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: agreed,
                    onChanged: (_) =>
                        agreedToShare.value = !agreedToShare.value,
                    activeColor: AppColors.indigo,
                    side: BorderSide(color: AppColors.steelBlue, width: 1.5),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => agreedToShare.value = !agreedToShare.value,
                      child: Padding(
                        padding: EdgeInsets.only(top: 11.h),
                        child: Text(
                          'I agree to share my info with matched learners',
                          style:
                              AppTextStyle.r14.copyWith(color: AppColors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            ListenableBuilder(
              listenable: Listenable.merge(
                  [nameController, phoneController, agreedToShare]),
              builder: (_, _) {
                final valid = isValid;
                return AnimatedOpacity(
                  opacity: valid ? 1.0 : 0.4,
                  duration: const Duration(milliseconds: 200),
                  child: IgnorePointer(
                    ignoring: !valid,
                    child: PrimaryButton(
                      buttonLabel: 'Find Learners',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.submit(
                            nameController.text.trim(),
                            phoneController.text.trim(),
                          );
                        }
                      },
                      padding: EdgeInsets.only(top: 16.h),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
