import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/data/word_model.dart';
import 'package:language/infrastructure/apis/grade_service.dart';

class AllItemView extends StatelessWidget {
  final GradeModel grade;
  const AllItemView({super.key, required this.grade});

  @override
  Widget build(BuildContext context) {
    List<WordModel> words = [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        title: Text(
          grade.name!,
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
        child: FutureBuilder(
          future: GradeService().fetchGradeByIdAll(grade.id!, grade.category!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CupertinoActivityIndicator(
                radius: 15.0,
                color: blue,
              );
            } else if (snapshot.hasError) {
              return Text('Xatolik: ${snapshot.error}');
            }
            words = snapshot.data!.toList();
            return ListView.separated(
              itemCount: words.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 0),
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                  title: Text("${words[index].en}"),
                  children: <Widget>[
                    ListTile(title: Text("${words[index].uz}")),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
