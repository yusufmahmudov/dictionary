import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:language/application/word/word_bloc.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/data/question.dart';
import 'package:language/data/word_model.dart';
import 'package:language/presentation/views/new.dart';
import 'package:language/presentation/views/test_view/en_test_view.dart';
import 'package:language/presentation/views/test_view/mixed_test_view.dart';
import 'package:language/presentation/views/test_view/uz_test_view.dart';
import 'package:language/presentation/views/test_view/written_test_view.dart';
import 'dart:io';

// ignore: must_be_immutable
class RandomTest extends StatelessWidget {
  final String test;
  final int count;

  RandomTest({super.key, required this.test, required this.count});

  List<WordModel> words = [];
  List<Question> question = [];

  @override
  Widget build(BuildContext context) {
    context.read<WordBloc>().add(GetWordsByActive(active: false));
    int c = count;
    if (c == 0) {
      c = 10;
    }

    return BlocBuilder<WordBloc, WordState>(
      builder: (context, state) {
        if (state.statusWord.isInProgress) {
          return const CupertinoActivityIndicator(
            radius: 15.0,
            color: blue,
          );
        } else if (state.words.isEmpty) {
          return const Center(
            child: Text(
              "Word is empty",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          );
        }

        state.words.shuffle();
        if (c == -1 || c > state.words.length) {
          words = state.words.toList();
          c = words.length;
        } else {
          words = state.words.take(c).toList();
        }
        if (words.length < 3) {
          return const NewView();
        }
        for (var w in words) {
          question.add(
            Question(
              uz: w.uz!,
              en: w.en!,
              question: "question",
              options: [],
              answerIndex: 0,
            ),
          );
        }

        if (test.compareTo("Test English") == 0) {
          return EnTestView(test: test, count: c, list: question);
        } else if (test.compareTo("Test Uzbek") == 0) {
          return UzTestView(test: test, count: c, list: question);
        } else if (test.compareTo("Test mixed") == 0) {
          return MixedTestView(test: test, count: c, list: question);
        } else if (test.compareTo("Written test") == 0) {
          return WrittenTestView(test: test, count: c, list: question);
        }

        return const Scaffold(
          body: Center(
            child: Text(
              "An error occurred",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }
}
