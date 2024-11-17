import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/data/grade_model.dart';

class PhraseAddView extends StatelessWidget {
  final GradeModel grade;
  const PhraseAddView({super.key, required this.grade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        title: const Text(
          "New Phrase",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: black,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
