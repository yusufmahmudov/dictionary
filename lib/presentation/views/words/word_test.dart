import 'package:flutter/cupertino.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/data/question.dart';
import 'package:language/data/word_model.dart';
import 'package:language/infrastructure/apis/word_service.dart';
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
    int c = count;
    if (c == 0) {
      c = 10;
    }
    return FutureBuilder(
      future: WordService().fetchWordByGrade(gradeId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoActivityIndicator(
            radius: 15.0,
            color: blue,
          );
        } else if (snapshot.hasError) {
          return Text('Xatolik: ${snapshot.error}');
        }
        if (c == -1 || c > snapshot.data!.length) {
          words = snapshot.data!.toList();
          c = words.length;
        } else {
          words = snapshot.data!.take(c).toList();
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

        return const Placeholder();
      },
    );
  }
}
