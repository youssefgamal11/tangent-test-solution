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

class _ConnectionsPageState extends State<ConnectionsPage> {
  late final Future<({String name, String phone})> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _loadUserData();
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
                    itemBuilder: (_, index) =>
                        LearnerCard(learner: mockLearners[index]),
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
