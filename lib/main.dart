import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tangent_test_solution/core/routing/app_router.dart';
import 'package:tangent_test_solution/core/routing/navigation_services.dart';
import 'package:tangent_test_solution/core/routing/route_names.dart'
    show RouteName;
import 'package:tangent_test_solution/core/storage/storage_service.dart';
import 'package:tangent_test_solution/core/theme/text_style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Vocaburary',
        theme: ThemeData(
          fontFamily: AppTextStyle.fontFamily,
          useMaterial3: true,
        ),
        initialRoute: RouteName.onBoarding,
        // StorageService.isOnboardingCompleted
        //     ? RouteName.homePage
        //     : RouteName.onBoarding,
        onGenerateRoute: AppRouter.allRoutes,
      ),
    );
  }
}
