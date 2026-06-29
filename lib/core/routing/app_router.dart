import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/cubits/cubit.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/pages/connections_page.dart';
import 'package:tangent_test_solution/features/findLearners/presentation/pages/find_learners_page.dart';
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
            child: const OnboardingPage(),
          ),
        );
      case RouteName.homePage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => HomeCubit()..init(),
            child: const HomePage(),
          ),
        );
      case RouteName.findLearners:
        final args = settings.arguments as Map<String, dynamic>?;
        final editMode = args?['editMode'] as bool? ?? false;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => FindLearnersCubit(editMode: editMode)..init(),
            child: const FindLearnersPage(),
          ),
        );
      case RouteName.connections:
        return MaterialPageRoute(
          builder: (_) => const ConnectionsPage(),
        );
      default:
        return MaterialPageRoute(builder: (_) => const SizedBox());
    }
  }
}