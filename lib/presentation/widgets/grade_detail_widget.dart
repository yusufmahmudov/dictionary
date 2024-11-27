import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/assets/icons.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/presentation/views/all_item/all_item_view.dart';
import 'package:language/presentation/views/phrases/phrase_test.dart';
import 'package:language/presentation/views/principle/principle_item_view.dart';
import 'package:language/presentation/views/words/word_test.dart';

class GradeDetailWidget extends StatelessWidget {
  final String test;
  final int count;
  final GradeModel grade;
  const GradeDetailWidget(
      {super.key,
      required this.test,
      required this.count,
      required this.grade});

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
                Container(child: selectIcon(grade.success!)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    grade.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${grade.count!} ${grade.category!.toLowerCase()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      grade.success! ? "Done" : "Not done",
                      style: TextStyle(
                        color: grade.success!
                            ? const Color.fromARGB(255, 9, 171, 82)
                            : red,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      openBuilder: (context, action) {
        if (count == -2) {
          return AllItemView(grade: grade);
        } else if (count == -3) {
          return PrincipleItemView(grade: grade);
        } else if (grade.category!.compareTo("Words") == 0) {
          return WordTest(test: test, count: count, gradeId: grade.id!);
        } else if (grade.category!.compareTo("Phrases") == 0) {
          return PhraseTest(test: test, count: count, gradeId: grade.id!);
        }
        return const Scaffold();
      },
    );
  }

  SvgPicture selectIcon(bool g) {
    if (g) {
      return AppIcons.star.svg(width: 24, height: 24, color: green);
    } else {
      return AppIcons.star.svg(width: 24, height: 24, color: red);
    }
  }
}
