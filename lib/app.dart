import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:language/application/grade/grade_bloc.dart';
import 'package:language/application/phrase/phrase_bloc.dart';
import 'package:language/application/principle/principle_bloc.dart';
import 'package:language/application/word/word_bloc.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/presentation/routes/app_routes.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GradeBloc(),
        ),
        BlocProvider(
          create: (context) => WordBloc(),
        ),
        BlocProvider(
          create: (context) => PhraseBloc(),
        ),
        BlocProvider(
          create: (context) => PrincipleBloc(),
        ),
      ],
      child: MaterialApp.router(
        restorationScopeId: 'app',
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.router,
        theme:
            ThemeData(appBarTheme: const AppBarTheme(surfaceTintColor: white)),
        builder: (context, child) {
          return KeyboardDismisser(child: child);
        },
      ),
    );
  }
}
