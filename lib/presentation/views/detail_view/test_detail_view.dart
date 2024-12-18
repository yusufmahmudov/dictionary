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
            color: white,
            iconSize: 24,
            icon: const Icon(
              Icons.more_vert,
              size: 28,
              color: white,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: const Text("10 test"),
                  onTap: () {
                    count = 10;
                    setState(() {});
                  },
                ),
                PopupMenuItem(
                  child: const Text("20 test"),
                  onTap: () {
                    count = 20;
                    setState(() {});
                  },
                ),
                PopupMenuItem(
                  child: const Text("30 test"),
                  onTap: () {
                    count = 30;
                    setState(() {});
                  },
                ),
                PopupMenuItem(
                  child: const Text("All test"),
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
      body: SingleChildScrollView(
        child: Padding(
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
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: AppIcons.how.svg(
                                    height: 24,
                                    width: 24,
                                    color: white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "How to pronounce",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: white,
                            ),
                          ),
                          // const Icon(
                          //   Icons.arrow_forward_ios_rounded,
                          //   color: white,
                          //   size: 28,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
