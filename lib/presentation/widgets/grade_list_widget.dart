import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:language/application/grade/grade_bloc.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/assets/icons.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/presentation/views/adder_view/grade_edit_view.dart';

class GradeListWidget extends StatelessWidget {
  final GradeModel grade;
  final int index;
  const GradeListWidget({
    super.key,
    required this.grade,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    void showDeleteGrade() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BlocBuilder<GradeBloc, GradeState>(
            builder: (context, state) {
              return AlertDialog(
                title: const Text('Delete Grade'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Do you want to delete this grade "${grade.name}"?',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'All words in this grade will be deleted.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      // delete grade
                      context.read<GradeBloc>().add(
                            DeleteGradeEvent(index: index, gradeId: grade.id!),
                          );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        GradeEditView(
          grade: grade,
          index: index,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.elliptical(30, 30),
            topRight: Radius.elliptical(3, 3),
            bottomLeft: Radius.elliptical(3, 3),
            bottomRight: Radius.elliptical(30, 30),
          ),
          color: Colors.white,
          border: Border.all(
            color: gray.withOpacity(.4),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
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
                      color: black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 2),
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
                const SizedBox(width: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GradeEditView(
                              grade: grade,
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.edit_outlined,
                        color: blue,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        showDeleteGrade();
                      },
                      child: const Icon(
                        Icons.delete_outline,
                        color: red,
                        size: 28,
                      ),
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
}

SvgPicture selectIcon(bool g) {
  if (g) {
    return AppIcons.star.svg(width: 24, height: 24, color: green);
  } else {
    return AppIcons.star.svg(width: 24, height: 24, color: red);
  }
}
