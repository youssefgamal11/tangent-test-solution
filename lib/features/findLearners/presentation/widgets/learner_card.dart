import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/features/shared/models/learner_model.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/widgets/level_badge.dart';
import 'package:lottie/lottie.dart';
import 'package:tangent_test_solution/core/utils/img_paths.dart';
import 'package:url_launcher/url_launcher.dart';

class LearnerCard extends StatelessWidget {
  const LearnerCard({super.key, required this.learner});

  final LearnerModel learner;

  Future<void> _openWhatsApp() async {
    final digits = learner.phone.replaceAll(RegExp(r'[^\d]'), '');
    final uri = Uri.parse('https://wa.me/$digits');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openWhatsApp,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: AppColors.darkBlue,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.steelBlue, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(learner.name, style: AppTextStyle.b14),
                      SizedBox(width: 8.w),
                      LevelBadge(level: learner.level),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${learner.wordsLearned} words',
                    style: AppTextStyle.r12.copyWith(color: AppColors.grey),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Lottie.asset(
                  ImgPath.whatsappAnimation,
                  width: 35.w,
                  height: 35.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 4.h),
                Text(
                  learner.phone,
                  style: AppTextStyle.r10.copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
