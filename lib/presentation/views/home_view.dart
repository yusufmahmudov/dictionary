import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/infrastructure/apis/user_service.dart';
import 'package:language/presentation/views/adder_view/grade_list_category.dart';
import 'package:language/presentation/views/adder_view/grade_list_view.dart';
import 'package:language/presentation/views/profile/profile_view.dart';
import 'package:language/presentation/widgets/builder_container.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black, size: 28),
        backgroundColor: Colors.blueAccent.shade400,
        title: const Text(
          "Dictionary",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: white,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            color: white,
            icon: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.dehaze_sharp,
                color: white,
              ),
            ),
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
                          const GradeListCategory(category: "Words"),
                    ),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const GradeListCategory(category: "Phrases"),
                    ),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const GradeListCategory(category: "Principle"),
                    ),
                  );
                  break;
                case 4:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileView(),
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
              const PopupMenuItem(
                value: 4,
                child: ListTile(
                  leading: Icon(Icons.person_outline_outlined),
                  title: Text('My Profile'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            children: [
              BuilderContainer(
                text: "Random dictionary",
                textBody: "Some random words",
                c: 0,
              ),
              SizedBox(height: 12),
              BuilderContainer(
                text: "Words",
                textBody: "A set of tests using words",
                c: -1,
              ),
              SizedBox(height: 12),
              BuilderContainer(
                text: "Phrases",
                textBody: "A set of tests using phrases",
                c: -2,
              ),
              SizedBox(height: 12),
              BuilderContainer(
                text: "All dictionaries",
                textBody: "All words and phrases",
                c: -3,
              ),
              SizedBox(height: 12),
              BuilderContainer(
                text: "Principle",
                textBody: "The entire set of principle",
                c: -4,
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
