import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:language/presentation/routes/routes_name.dart';
import 'package:language/presentation/views/error_view.dart';
import 'package:language/presentation/views/home_view.dart';
import 'package:language/presentation/views/profile/login_view.dart';
import 'package:language/presentation/views/profile/profile_view.dart';
import 'package:language/presentation/views/profile/register_view.dart';
import 'package:language/presentation/views/splash_view.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRouteName.splash,
    errorBuilder: (context, state) => const ErrorView(),
    routes: [
      GoRoute(
        path: AppRouteName.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRouteName.errorFound,
        builder: (context, state) => const ErrorView(),
      ),
      GoRoute(
        path: AppRouteName.home,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: AppRouteName.register,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: AppRouteName.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRouteName.profile,
        builder: (context, state) => const ProfileView(),
      )
    ],
  );
}
