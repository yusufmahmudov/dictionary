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
    return GestureDetector(
      onTap: () {
        if (count == -2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllItemView(grade: grade),
            ),
          );
        } else if (count == -3) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PrincipleItemView(grade: grade),
            ),
          );
        } else if (grade.category!.compareTo("Words") == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  WordTest(test: test, count: count, gradeId: grade.id!),
            ),
          );
        } else if (grade.category!.compareTo("Phrases") == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PhraseTest(test: test, count: count, gradeId: grade.id!),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(3),
                    ),
                  ),
                  child: selectIcon(grade.success!),
                ),
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
                            ? const Color.fromARGB(255, 18, 216, 107)
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
        ),
      ),
    );
  }

  SvgPicture selectIcon(bool g) {
    if (g) {
      return AppIcons.star.svg(
          width: 24,
          height: 24,
          color: const Color.fromARGB(255, 18, 216, 107));
    } else {
      return AppIcons.star.svg(width: 24, height: 24, color: red);
    }
  }
}
