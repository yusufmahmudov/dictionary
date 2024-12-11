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

// ignore: must_be_immutable
class WordTest extends StatelessWidget {
  final String test;
  final int count;
  final int gradeId;

  WordTest(
      {super.key,
      required this.test,
      required this.count,
      required this.gradeId});

  List<WordModel> words = [];
  List<Question> question = [];

  @override
  Widget build(BuildContext context) {
    context.read<WordBloc>().add(GetWordsByGrade(gradeId: gradeId));
    int c = count;
    if (c == 0) {
      c = 10;
    }

    Widget customScaffold(String title) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: blue,
          title: const Text(
            "Words",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: white,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: white,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return BlocBuilder<WordBloc, WordState>(
      builder: (context, state) {
        if (state.statusWord.isInProgress) {
          return const CupertinoActivityIndicator(
            radius: 15.0,
            color: blue,
          );
        } else if (state.words.isEmpty) {
          return customScaffold("Words is empty");
        } else if (state.words.length < 10) {
          return customScaffold("The value in the words must be at least 10");
        }

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
