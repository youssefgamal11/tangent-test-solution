import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/theme/colors.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';

class ConnectionsAppBar extends StatelessWidget {
  const ConnectionsAppBar({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.indigo,
                  size: 14.sp,
                ),
                SizedBox(width: 4.w),
                Text('Back', style: AppTextStyle.r14.copyWith(color: AppColors.indigo)),
              ],
            ),
          ),
          SizedBox(width: 60.w),
          Text(
            'Connections',
            style: AppTextStyle.b18,
            textAlign: TextAlign.center,
          ),
       ],
      ),
    );
  }
}
