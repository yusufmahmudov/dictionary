import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/presentation/routes/app_routes.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.router,
      theme: ThemeData(appBarTheme: const AppBarTheme(surfaceTintColor: white)),
      builder: (context, child) {
        return KeyboardDismisser(child: child);
      },
    );
  }
}
