import 'package:flutter/material.dart';
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
    return GestureDetector(
      onTap: () {
        if (text.compareTo("All dictionaries") == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GradeView(
                  test: "", count: -2, gradeName: 'All dictionaries'),
            ),
          ).then((_) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          });
        } else if (text.compareTo("Principle") == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const GradeView(test: "", count: -3, gradeName: "Principle"),
            ),
          ).then((_) {
            // ignore: use_build_context_synchronously
            if (Navigator.canPop(context)) {
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            }
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TestDetailView(appBarText: text),
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
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: selectedIcon(c),
                      ),
                    ),
                  ),
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
                        color: white,
                      ),
                    ),
                    Text(
                      textBody,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: white,
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
        ),
      ),
    );
  }
}

Widget selectedIcon(int c) {
  if (c == 0) {
    return AppIcons.random.svg(width: 24, height: 24, color: white);
  } else if (c == -1) {
    return AppIcons.word.svg(width: 24, height: 24, color: white);
  } else if (c == -2) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: AppIcons.phrase.svg(width: 36, height: 36, color: white),
    );
  } else if (c == -3) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AppIcons.list.svg(width: 24, height: 24, color: white),
    );
  } else if (c == -4) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AppIcons.principle.svg(width: 24, height: 24, color: white),
    );
  }
  return AppIcons.word.svg();
}
