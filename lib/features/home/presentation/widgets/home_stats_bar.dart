import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/core/utils/img_paths.dart';

class HomeStatsBar extends StatelessWidget {
  const HomeStatsBar({
    super.key,
    required this.streak,
    required this.wordsCompleted,
    required this.dailyGoal,
  });

  final int streak;
  final int wordsCompleted;
  final int dailyGoal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          _StreakBadge(streak: streak),
          SizedBox(width: 12.w),
          _ProgressBadge(completed: wordsCompleted, total: dailyGoal),
        ],
      ),
    );
  }
}

class _StreakBadge extends StatefulWidget {
  const _StreakBadge({required this.streak});

  final int streak;

  @override
  State<_StreakBadge> createState() => _StreakBadgeState();
}

class _StreakBadgeState extends State<_StreakBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 4), () {
          if (mounted) {
            controller.reset();
            controller.forward();
          }
        });
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          ImgPath.flameAnimation,
          width: 52.w,
          height: 52.w,
          fit: BoxFit.fill,
        ),
        SizedBox(width: 6.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.streak}',
              style: AppTextStyle.b14.copyWith(color: AppColors.coral),
            ),
            SizedBox(height: 2.h),
            Text(
              'streak',
              style: AppTextStyle.r10.copyWith(color: AppColors.grey),
            ),
          ],
        ),
      ],
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (_, _) {
        final p = controller.value;
        return Container(
          decoration: BoxDecoration(
            color: AppColors.slateBlue,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.steelBlue, width: 1.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                  child: content,
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1.6 + p * 3.2, -1.0),
                        end: Alignment(-1.0 + p * 3.2, 1.0),
                        colors: [
                          Colors.transparent,
                          Colors.white.withValues(alpha: 0.08),
                          Colors.white.withValues(alpha: 0.18),
                          Colors.white.withValues(alpha: 0.08),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProgressBadge extends StatelessWidget {
  const _ProgressBadge({required this.completed, required this.total});

  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.slateBlue,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.steelBlue, width: 1.5),
      ),
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.6),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  )),
                  child: FadeTransition(opacity: animation, child: child),
                ),
                child: Text(
                  '$completed',
                  key: ValueKey(completed),
                  style: AppTextStyle.b11.copyWith(color: AppColors.white),
                ),
              ),
              Text(
                '/$total',
                style: AppTextStyle.b11.copyWith(color: AppColors.white),
              ),
            ],
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: completed / total),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              builder: (context, value, _) => ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 4.h,
                  backgroundColor: AppColors.steelBlue,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.cyan),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
