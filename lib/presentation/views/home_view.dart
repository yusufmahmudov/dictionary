import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/presentation/views/error_view.dart';
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ErrorView()));
                  break;
                case 1:
                  print('Yangi inkognito varaq tanlandi');
                  break;
                case 2:
                  print('Barcha varaqni yopish tanlandi');
                  break;
                case 3:
                  print('Sozlamalar tanlandi');
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: ListTile(
                  leading: Icon(Icons.add),
                  title: Text('Yangi varaq'),
                ),
              ),
              const PopupMenuItem(
                value: 1,
                child: ListTile(
                  leading: Icon(Icons.visibility_off),
                  title: Text('Yangi Inkognito varaq'),
                ),
              ),
              const PopupMenuItem(
                value: 2,
                child: ListTile(
                  leading: Icon(Icons.close),
                  title: Text('Barcha varaqni yopish'),
                ),
              ),
              const PopupMenuItem(
                value: 3,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Sozlamalar'),
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
