import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/cubits/states.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/widgets/connections_app_bar.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/widgets/learner_card.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/widgets/my_info_card.dart';

class ConnectionsPage extends StatelessWidget {
  const ConnectionsPage({
    super.key,
    required this.name,
    required this.phone,
    required this.learners,
  });

  final String name;
  final String phone;
  final List<LearnerModel> learners;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: Column(
          children: [
                          ConnectionsAppBar(),

            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                children: [
                  MyInfoCard(
                    name: name,
                    phone: phone,
                    level: 'Intermediate',
                    onEdit: () => Navigator.pop(context),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'LEARNERS AT YOUR LEVEL',
                    style: AppTextStyle.r10.copyWith(
                      color: AppColors.grey,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  ...learners.map((learner) => LearnerCard(learner: learner)),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
