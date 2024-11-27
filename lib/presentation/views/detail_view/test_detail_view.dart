import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/assets/icons.dart';
import 'package:language/presentation/widgets/test_detail_widget.dart';
import 'package:language/utils/caller.dart';

class TestDetailView extends StatefulWidget {
  final String appBarText;
  const TestDetailView({super.key, required this.appBarText});

  @override
  State<TestDetailView> createState() => _TestDetailViewState();
}

class _TestDetailViewState extends State<TestDetailView> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        title: Text(
          widget.appBarText,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: white,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            iconSize: 24,
            icon: const Icon(
              Icons.more_vert,
              size: 28,
              color: white,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Text("10"),
                  onTap: () {
                    count = 10;
                    setState(() {});
                  },
                ),
                PopupMenuItem(
                  child: const Text("20"),
                  onTap: () {
                    count = 20;
                    setState(() {});
                  },
                ),
                PopupMenuItem(
                  child: const Text("30"),
                  onTap: () {
                    count = 30;
                    setState(() {});
                  },
                ),
                PopupMenuItem(
                  child: const Text("All"),
                  onTap: () {
                    count = -1;
                    setState(() {});
                  },
                ),
              ];
            },
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            TestDetailWidget(
              test: "Test English",
              appBarText: widget.appBarText,
              count: count,
              c: 0,
            ),
            const SizedBox(height: 12),
            TestDetailWidget(
              test: "Test Uzbek",
              appBarText: widget.appBarText,
              count: count,
              c: -1,
            ),
            const SizedBox(height: 12),
            TestDetailWidget(
              test: "Test mixed",
              appBarText: widget.appBarText,
              count: count,
              c: -2,
            ),
            const SizedBox(height: 12),
            TestDetailWidget(
              test: "Written test",
              appBarText: widget.appBarText,
              count: count,
              c: -3,
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Caller.launchUrlWeb(
                  "https://www.google.com/search?q=How%20to%20pronounce"),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blueAccent.shade100,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: AppIcons.how.svg(
                            height: 24,
                            width: 24,
                            color: white,
                          ),
                        ),
                        const Text(
                          "How to pronounce",
                          style: TextStyle(
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
