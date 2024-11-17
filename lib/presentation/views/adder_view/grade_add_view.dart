import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';

class GradeAddView extends StatelessWidget {
  final int id;
  const GradeAddView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        title: const Text(
          "New Grade",
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
