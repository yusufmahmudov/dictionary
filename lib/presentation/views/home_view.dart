import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/presentation/views/adder_view/grade_list_view.dart';
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
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              // Har bir element bosilganda nima bo'lishini sozlang
              switch (value) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const GradeListView(category: "Grade"),
                    ),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const GradeListView(category: "Words"),
                    ),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const GradeListView(category: "Phrases"),
                    ),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const GradeListView(category: "Principle"),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: ListTile(
                  leading: Icon(Icons.list_alt_rounded),
                  title: Text('Grade List'),
                ),
              ),
              const PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.post_add_rounded),
                  title: Text('New words'),
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.post_add_rounded),
                  title: Text('New phrases'),
                ),
              ),
              const PopupMenuItem(
                value: 3,
                child: ListTile(
                  leading: Icon(Icons.my_library_add_outlined),
                  title: Text('New principle'),
                ),
              ),
            ],
          ),
        ],
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
