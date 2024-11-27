import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: selectIcon(c),
                ),
                Text(
                  test,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                    color: white,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: white,
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

  SvgPicture selectIcon(int c) {
    if (c == 0) {
      return AppIcons.en.svg(width: 24, height: 24, color: white);
    } else if (c == -1) {
      return AppIcons.uz.svg(width: 24, height: 24, color: white);
    } else if (c == -2) {
      return AppIcons.mix.svg(width: 24, height: 24, color: white);
    } else {
      return AppIcons.write.svg(width: 24, height: 24, color: white);
    }
  }
}
