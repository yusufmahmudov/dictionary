import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:language/presentation/views/detail_view/grade_view.dart';
import 'package:language/presentation/views/detail_view/test_detail_view.dart';

class BuilderContainer extends StatelessWidget {
  final String text;

  const BuilderContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      transitionDuration: const Duration(milliseconds: 500),
      closedColor: Colors.white,
      closedBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 22),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color.fromARGB(255, 68, 67, 67),
                  size: 28,
                ),
              ],
            ),
          ),
        );
      },
      openBuilder: (context, action) {
        if (text.compareTo("All dictionaries") == 0) {
          return const GradeView(
              test: "", count: -2, gradeName: 'All dictionaries');
        } else if (text.compareTo("Principle") == 0) {
          return const GradeView(test: "", count: -3, gradeName: "Principle");
        }
        return TestDetailView(appBarText: text);
      },
    );
  }
}
