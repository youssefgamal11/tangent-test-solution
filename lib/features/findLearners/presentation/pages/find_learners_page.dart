import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/cubits/cubit.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/cubits/states.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/pages/connections_page.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/widgets/connections_app_bar.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/widgets/find_learners_form.dart';

class FindLearnersPage extends StatelessWidget {
  const FindLearnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: BlocConsumer<FindLearnersCubit, FindLearnersState>(
          listenWhen: (prev, curr) =>
              curr.status == FindLearnersStatus.results &&
              prev.status != FindLearnersStatus.results,
          listener: (context, state) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ConnectionsPage(
                  name: state.name,
                  phone: state.phoneNumber,
                  learners: state.learners,
                ),
              ),
            );
            context.read<FindLearnersCubit>().resetToForm();
          },
          builder: (context, state) {
            return const Column(
              children: [
                ConnectionsAppBar(),
                Expanded(child: FindLearnersForm()),
              ],
            );
          },
        ),
      ),
    );
  }
}
