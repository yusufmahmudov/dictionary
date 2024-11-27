import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/assets/icons.dart';
import 'package:language/presentation/views/detail_view/grade_view.dart';
import 'package:language/presentation/views/detail_view/test_detail_view.dart';

class BuilderContainer extends StatelessWidget {
  final String text;
  final String textBody;
  final int c;

  const BuilderContainer(
      {super.key, required this.text, required this.textBody, required this.c});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      transitionDuration: const Duration(milliseconds: 500),
      closedElevation: 5,
      openElevation: 5,
      closedColor: white,
      transitionType: ContainerTransitionType.fadeThrough,
      closedBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: selectedIcon(c),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        color: black,
                      ),
                    ),
                    Text(
                      textBody,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: black,
                      ),
                    ),
                  ],
                ),
                // const Icon(
                //   Icons.arrow_forward_ios_rounded,
                //   color: grey,
                //   size: 28,
                // ),
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

  SvgPicture selectedIcon(int c) {
    if (c == 0) {
      return AppIcons.random.svg(width: 40, height: 40, color: black);
    } else if (c == -1) {
      return AppIcons.word.svg(width: 36, height: 36, color: black);
    } else if (c == -2) {
      return AppIcons.phrase.svg(width: 36, height: 36, color: black);
    } else if (c == -3) {
      return AppIcons.list.svg(width: 36, height: 36, color: black);
    } else if (c == -4) {
      return AppIcons.principle.svg(width: 36, height: 36, color: black);
    }
    return AppIcons.word.svg();
  }
}
