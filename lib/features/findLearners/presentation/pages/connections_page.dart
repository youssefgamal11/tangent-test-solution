import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/routing/route_names.dart';
import 'package:tangent_test_solution/core/storage/storage_service.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/widgets/connections_app_bar.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/widgets/learner_card.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/widgets/my_info_card.dart';
import 'package:tangent_test_solution/features/shared/data/learners_data.dart';

class ConnectionsPage extends StatefulWidget {
  const ConnectionsPage({super.key});

  @override
  State<ConnectionsPage> createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends State<ConnectionsPage>
    with SingleTickerProviderStateMixin {
  late final Future<({String name, String phone})> _userDataFuture;
  late final AnimationController _animController;
  late final List<Animation<double>> _itemAnimations;

  static const _staggerMs = 400;
  static const _itemMs = 500;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _loadUserData();

    final totalMs =
        (mockLearners.length - 1) * _staggerMs + _itemMs;
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: totalMs),
    )..forward();

    _itemAnimations = List.generate(mockLearners.length, (i) {
      final start = (i * _staggerMs) / totalMs;
      final end = start + _itemMs / totalMs;
      return CurvedAnimation(
        parent: _animController,
        curve: Interval(start, end, curve: Curves.easeOut),
      );
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<({String name, String phone})> _loadUserData() async {
    final name = await StorageService.getUserName() ?? '';
    final phone = await StorageService.getUserPhone() ?? '';
    return (name: name, phone: phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: FutureBuilder(
          future: _userDataFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox.shrink();
            final data = snapshot.data!;
            return Column(
              children: [
                const ConnectionsAppBar(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: MyInfoCard(
                    name: data.name,
                    phone: data.phone,
                    level: 'Intermediate',
                    onEdit: () => Navigator.of(context).pushReplacementNamed(
                      RouteName.findLearners,
                      arguments: {'editMode': true},
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'LEARNERS AT YOUR LEVEL',
                      style: AppTextStyle.r10.copyWith(
                        color: AppColors.grey,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    itemCount: mockLearners.length,
                    itemBuilder: (_, index) {
                      final anim = _itemAnimations[index];
                      return AnimatedBuilder(
                        animation: anim,
                        builder: (_, child) => Opacity(
                          opacity: anim.value,
                          child: Transform.translate(
                            offset: Offset(0, 28 * (1 - anim.value)),
                            child: child,
                          ),
                        ),
                        child: LearnerCard(learner: mockLearners[index]),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
