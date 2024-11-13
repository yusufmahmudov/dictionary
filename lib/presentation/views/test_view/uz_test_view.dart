import 'package:flutter/widgets.dart';
import 'package:language/data/question.dart';

class UzTestView extends StatelessWidget {
  final String test;
  final int count;
  final List<Question> list;
  const UzTestView(
      {super.key, required this.test, required this.count, required this.list});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
