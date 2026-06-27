import 'package:flutter/material.dart';
import 'package:tangent_test_solution/features/onBoarding/presentation/pages/onBoarding_page.dart';
import 'route_names.dart';

class AppRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.onBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
        );
 
      default:
        return MaterialPageRoute(builder: (_) => const SizedBox());
    }
  }
}