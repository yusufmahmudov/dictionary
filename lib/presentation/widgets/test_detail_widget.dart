import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/assets/icons.dart';
import 'package:language/presentation/views/detail_view/grade_view.dart';
import 'package:language/presentation/views/random/random_test.dart';

class TestDetailWidget extends StatelessWidget {
  final String test;
  final String appBarText;
  final int count;
  final int c;
  const TestDetailWidget(
      {super.key,
      required this.test,
      required this.appBarText,
      required this.count,
      required this.c});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (appBarText.compareTo("Random dictionary") == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RandomTest(count: count, test: test),
            ),
          );
        } else if (appBarText.compareTo("Words") == 0 ||
            appBarText.compareTo("Phrases") == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  GradeView(test: test, count: count, gradeName: appBarText),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.elliptical(30, 30),
            topRight: Radius.elliptical(3, 3),
            bottomLeft: Radius.elliptical(3, 3),
            bottomRight: Radius.elliptical(30, 30),
          ),
          color: Colors.blueAccent.shade200,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: selectedIcon(c),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  test,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                    color: white,
                  ),
                ),
                // const Icon(
                //   Icons.arrow_forward_ios_rounded,
                //   color: white,
                //   size: 28,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget selectedIcon(int c) {
  if (c == 0) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: AppIcons.en.svg(width: 24, height: 24, color: white),
    );
  } else if (c == -1) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: AppIcons.uz.svg(width: 36, height: 36, color: white),
    );
  } else if (c == -2) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: AppIcons.mix.svg(width: 24, height: 24, color: white),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: AppIcons.write.svg(width: 24, height: 24, color: white),
    );
  }
}
