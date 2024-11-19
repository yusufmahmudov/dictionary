import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';

class NewView extends StatelessWidget {
  const NewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Error",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Not enough information!",
          style:
              TextStyle(color: red, fontSize: 24, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
