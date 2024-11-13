import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/presentation/views/detail_view/principle_detail_view.dart';
import 'package:language/presentation/views/detail_view/special_detail_view.dart';
import 'package:language/presentation/views/detail_view/test_detail_view.dart';

class BuilderContainer extends StatelessWidget {
  final String text;

  const BuilderContainer({super.key, required this.text});

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
                  text,
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
        if (text.compareTo("All dictionaries") == 0) {
          return SpecialDetailView(appBarText: text);
        } else if (text.compareTo("Principle") == 0) {
          return PrincipleDetailView(appBarText: text);
        }
        return TestDetailView(appBarText: text);
      },
    );
  }
}
