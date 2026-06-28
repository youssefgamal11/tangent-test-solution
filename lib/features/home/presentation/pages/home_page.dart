import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/routing/route_names.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/features/home/presentation/cubits/cubit.dart';
import 'package:tangent_test_solution/features/home/presentation/widgets/dots_indicator.dart';
import 'package:tangent_test_solution/features/home/presentation/widgets/find_learners_card.dart';
import 'package:tangent_test_solution/features/home/presentation/widgets/home_stats_bar.dart';
import 'package:tangent_test_solution/features/home/presentation/widgets/week_strip_toast.dart';
import 'package:tangent_test_solution/features/home/presentation/widgets/word_swipe_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listenWhen: (prev, curr) =>
              curr.showStreakToast && !prev.showStreakToast,
          listener: (context, state) {
            WeekStripToast.show(
              context,
              streak: state.streak,
              weeklyProgress: state.weeklyProgress,
            );
            context.read<HomeCubit>().resetStreakToast();
          },
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: 20.h),
                HomeStatsBar(
                  streak: state.streak,
                  wordsCompleted: state.wordsCompleted,
                  dailyGoal: state.dailyGoal,
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: PageView.builder(
                    clipBehavior: Clip.none,
                    controller: cubit.pageController,
                    onPageChanged: cubit.onCardChanged,
                    itemCount: state.sessionWords.length,
                    itemBuilder: (_, i) => WordSwipeCard(
                      card: state.sessionWords[i],
                      index: i,
                      pageController: cubit.pageController,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                DotsIndicator(
                  count: state.sessionWords.length,
                  current: state.currentCardIndex,
                ),
                SizedBox(height: 8.h),
                Text(
                  'swipe left or right',
                  style: AppTextStyle.r12.copyWith(color: AppColors.grey),
                ),
                SizedBox(height: 16.h),
                FindLearnersCard(
                  onTap: () => Navigator.of(context)
                      .pushNamed(RouteName.findLearners),
                ),
                SizedBox(height: 24.h),
              ],
            );
          },
        ),
      ),
    );
  }
}
