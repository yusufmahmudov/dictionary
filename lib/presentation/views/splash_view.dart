import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/assets/icons.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              blue,
              Color(0xFF1E88E5), // Rich blue
              Color(0xFF64B5F6), // Lighter blue
              Color(0xFFBBDEFB), // Very light blue
            ],
            stops: [0.0, 0.3, 0.6, 1.0],
            transform: GradientRotation(0.3),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: AppIcons.quiz.svg(height: 180, color: white),
          ),
        ),
      ),
    );
  }
}
