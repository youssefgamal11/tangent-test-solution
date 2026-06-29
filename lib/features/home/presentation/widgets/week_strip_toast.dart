import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/core/utils/img_paths.dart';
import 'package:tangent_test_solution/features/home/presentation/widgets/week_strip.dart';

class WeekStripToast extends StatefulWidget {
  const WeekStripToast({
    super.key,
    required this.streak,
    required this.weeklyProgress,
    required this.onDismiss,
  });

  final int streak;
  final List<bool> weeklyProgress;
  final VoidCallback onDismiss;

  static void show(
    BuildContext context, {
    required int streak,
    required List<bool> weeklyProgress,
  }) {
    late OverlayEntry overlay;
    overlay = OverlayEntry(
      builder: (_) => WeekStripToast(
        streak: streak,
        weeklyProgress: weeklyProgress,
        onDismiss: overlay.remove,
      ),
    );
    Overlay.of(context).insert(overlay);
  }

  @override
  State<WeekStripToast> createState() => _WeekStripToastState();
}

class _WeekStripToastState extends State<WeekStripToast>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Offset> slideAnimation;
  late final Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutBack,
    ));

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    controller.forward();
    Future.delayed(const Duration(milliseconds: 4000), _dismiss);
  }

  Future<void> _dismiss() async {
    if (!mounted) return;
    await controller.animateBack(
      0,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
    widget.onDismiss();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60.h,
      left: 24.w,
      right: 24.w,
      child: SlideTransition(
        position: slideAnimation,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.slateBlue,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.steelBlue, width: 1.5),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Lottie.asset(
                        ImgPath.flameAnimation,
                        width: 40.w,
                        height: 40.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Day ${widget.streak} streak!',
                        style:
                            AppTextStyle.b18.copyWith(color: AppColors.coral),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  WeekStrip(weeklyProgress: widget.weeklyProgress),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
