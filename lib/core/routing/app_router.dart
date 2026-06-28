import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangent_test_solution/features/home/presentation/cubits/cubit.dart';
import 'package:tangent_test_solution/features/home/presentation/pages/home_page.dart';
import 'package:tangent_test_solution/features/onBoarding/presentation/cubits/cubit.dart';
import 'package:tangent_test_solution/features/onBoarding/presentation/pages/onBoarding_page.dart';
import 'route_names.dart';

class AppRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.onBoarding:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => OnboardingCubit(),
            child: const OnboardingPage()),
        );
      case RouteName.homePage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => HomeCubit()..init(),
            child: const HomePage(),
          ),
        );
 
      default:
        return MaterialPageRoute(builder: (_) => const SizedBox());
    }
  }
}