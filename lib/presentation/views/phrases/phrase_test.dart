import 'package:flutter/material.dart';
import 'package:language/data/phrase_model.dart';
import 'package:language/data/question.dart';
import 'package:language/infrastructure/apis/phrase_service.dart';
import 'package:language/presentation/views/test_view/en_test_view.dart';
import 'package:language/presentation/views/test_view/mixed_test_view.dart';
import 'package:language/presentation/views/test_view/uz_test_view.dart';
import 'package:language/presentation/views/test_view/written_test_view.dart';

// ignore: must_be_immutable
class PhraseTest extends StatelessWidget {
  final String test;
  final int count;
  final int gradeId;

  PhraseTest(
      {super.key,
      required this.test,
      required this.count,
      required this.gradeId});

  List<PhraseModel> phrase = [];
  List<Question> question = [];

  @override
  Widget build(BuildContext context) {
    int c = count;
    return FutureBuilder(
      future: PhraseService().fetchPhraseByGrade(gradeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Xatolik: ${snapshot.error}');
        }
        phrase = snapshot.data!.take(c).toList();
        for (var p in phrase) {
          question.add(
            Question(
              uz: p.uz!,
              en: p.en!,
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

        return const Placeholder();
      },
    );
  }
}
