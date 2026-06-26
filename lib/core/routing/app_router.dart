import 'package:flutter/material.dart';
import 'route_names.dart';

class AppRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.onBoarding:
        // return MaterialPageRoute(
        //   // builder: (_) => const On(),
        // );
 
      default:
        return MaterialPageRoute(builder: (_) => const SizedBox());
    }
  }
}