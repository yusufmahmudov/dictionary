import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/assets/icons.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/presentation/views/adder_view/grade_add_view.dart';
import 'package:language/presentation/views/adder_view/phrase_add_view.dart';
import 'package:language/presentation/views/adder_view/principle_add_view.dart';
import 'package:language/presentation/views/adder_view/word_add_view.dart';

class GradeListWidget extends StatelessWidget {
  final GradeModel grade;
  final String category;
  final int index;
  const GradeListWidget({
    super.key,
    required this.grade,
    required this.category,
    required this.index,
  });

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
          padding: const EdgeInsets.fromLTRB(12, 0, 20, 0),
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
                          fontWeight: FontWeight.w500, fontSize: 14),
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
        if (category.compareTo("Grade") == 0) {
          return GradeAddView(
            grade: grade,
            index: index,
          );
        } else if (grade.category!.compareTo("Words") == 0) {
          return WordAddView(grade: grade);
        } else if (grade.category!.compareTo("Phrases") == 0) {
          return PhraseAddView(grade: grade);
        } else if (grade.category!.compareTo("Principle") == 0) {
          return PrincipleAddView(grade: grade);
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
