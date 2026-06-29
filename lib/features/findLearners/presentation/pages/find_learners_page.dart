import 'package:flutter/material.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/widgets/connections_app_bar.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/widgets/find_learners_form.dart';

class FindLearnersPage extends StatelessWidget {
  const FindLearnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: const Column(
              children: [
                ConnectionsAppBar(),
                Expanded(child: FindLearnersForm()),
              ],
            )
      ),
    );
  }
}
