import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:language/presentation/routes/routes_name.dart';
import 'package:language/presentation/views/error_view.dart';
import 'package:language/presentation/views/home_view.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRouteName.home,
    errorBuilder: (context, state) => const ErrorView(),
    routes: [
      GoRoute(
        path: AppRouteName.errorFound,
        builder: (context, state) => const ErrorView(),
      ),
      GoRoute(
        path: AppRouteName.home,
        builder: (context, state) => const HomeView(),
      ),
    ],
  );
}
