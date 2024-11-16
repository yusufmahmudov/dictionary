import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/presentation/views/detail_view/grade_view.dart';
import 'package:language/presentation/views/random/random_test.dart';

class TestDetailWidget extends StatelessWidget {
  final String test;
  final String appBarText;
  final int count;
  const TestDetailWidget(
      {super.key,
      required this.test,
      required this.appBarText,
      required this.count});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      transitionDuration: const Duration(milliseconds: 500),
      closedColor: Colors.blueAccent.shade100,
      closedBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  test,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 22),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: black,
                  size: 28,
                ),
              ],
            ),
          ),
        );
      },
      openBuilder: (context, action) {
        // if (count.isEmpty) {
        //   count = "10";
        // }
        if (appBarText.compareTo("Random dictionary") == 0) {
          return RandomTest(count: count, test: test);
        } else if (appBarText.compareTo("Words") == 0 ||
            appBarText.compareTo("Phrases") == 0) {
          return GradeView(test: test, count: count, gradeName: appBarText);
        }
        return const Scaffold();
      },
    );
  }
}
