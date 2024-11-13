import 'package:flutter/widgets.dart';
import 'package:language/data/question.dart';

class WrittenTestView extends StatelessWidget {
  final String test;
  final int count;
  final List<Question> list;
  const WrittenTestView(
      {super.key, required this.test, required this.count, required this.list});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
