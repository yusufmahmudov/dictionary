import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/presentation/views/principle/principle_item_view.dart';

class PrincipleDetailWidget extends StatelessWidget {
  final String branch;
  const PrincipleDetailWidget({super.key, required this.branch});

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
                    branch,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 22),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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
        return PrincipleItemView(appBarText: branch);
        // return AllItemView(appBarText: branch);
      },
    );
  }
}
