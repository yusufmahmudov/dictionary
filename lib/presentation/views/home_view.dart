import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/presentation/widgets/builder_container.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black, size: 28),
        backgroundColor: Colors.blueAccent.shade400,
        title: const Text(
          "Dictionary",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: black,
          ),
        ),
        centerTitle: true,
      ),
      endDrawer: const Drawer(
        width: 250,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            BuilderContainer(text: "Random dictionary"),
            SizedBox(height: 12),
            BuilderContainer(text: "Words"),
            SizedBox(height: 12),
            BuilderContainer(text: "Phrases"),
            SizedBox(height: 12),
            BuilderContainer(text: "All dictionaries"),
            SizedBox(height: 12),
            BuilderContainer(text: "Principle"),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
