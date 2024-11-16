import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
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
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    grade.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 22),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                    grade.success!
                        ? Icons.check_circle_rounded
                        : Icons.circle_outlined,
                    color: grade.success! ? green : red,
                    size: 32),
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
}
