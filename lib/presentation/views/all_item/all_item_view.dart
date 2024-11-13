import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';

class AllItemView extends StatelessWidget {
  final String appBarText;
  const AllItemView({super.key, required this.appBarText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        title: Text(
          appBarText,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: black,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 12.0),
        //     child: Icon(
        //       Icons.edit,
        //       color: black,
        //     ),
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.separated(
          itemCount: 5,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 0),
          itemBuilder: (BuildContext context, int index) {
            return const ExpansionTile(
              title: Text("so'z"),
              // subtitle: Text('Trailing expansion arrow icon'),
              children: <Widget>[
                ListTile(title: Text('tarjfuahhdfbhdbhddfbdfbhdimasi')),
              ],
            );
          },
        ),
      ),
    );
  }
}
