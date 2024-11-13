import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/presentation/widgets/test_detail_widget.dart';
import 'package:language/utils/caller.dart';

class TestDetailView extends StatefulWidget {
  final String appBarText;
  const TestDetailView({super.key, required this.appBarText});

  @override
  State<TestDetailView> createState() => _TestDetailViewState();
}

class _TestDetailViewState extends State<TestDetailView> {
  TextEditingController controllerItemCount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controllerItemCount.text = "10";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        title: Text(
          widget.appBarText,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: black,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            iconSize: 24,
            icon: const Icon(
              Icons.more_vert,
              size: 28,
              color: black,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Text("10"),
                  onTap: () {
                    controllerItemCount.text = "10";
                  },
                ),
                PopupMenuItem(
                  child: const Text("20"),
                  onTap: () {
                    controllerItemCount.text = "20";
                  },
                ),
                PopupMenuItem(
                  child: const Text("30"),
                  onTap: () {
                    controllerItemCount.text = "30";
                  },
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            TestDetailWidget(
                test: "Test English",
                appBarText: widget.appBarText,
                count: controllerItemCount.text),
            const SizedBox(height: 12),
            TestDetailWidget(
                test: "Test Uzbek",
                appBarText: widget.appBarText,
                count: controllerItemCount.text),
            const SizedBox(height: 12),
            TestDetailWidget(
                test: "Test mixed",
                appBarText: widget.appBarText,
                count: controllerItemCount.text),
            const SizedBox(height: 12),
            TestDetailWidget(
                test: "Written test",
                appBarText: widget.appBarText,
                count: controllerItemCount.text),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Caller.launchUrlWeb(
                  "https://www.google.com/search?q=How%20to%20pronounce"),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blueAccent.shade100,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "How to pronounce",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 22),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: black,
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
