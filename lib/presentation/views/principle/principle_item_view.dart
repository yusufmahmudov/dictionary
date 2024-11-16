import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/data/principle_model.dart';
import 'package:language/infrastructure/apis/principle_service.dart';

class PrincipleItemView extends StatelessWidget {
  final GradeModel grade;
  const PrincipleItemView({super.key, required this.grade});

  @override
  Widget build(BuildContext context) {
    List<PrincipleModel> principle = [];
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: FutureBuilder(
          future: PrincipleService().fetchPrincipleByGrade(grade.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CupertinoActivityIndicator(
                radius: 15.0,
                color: blue,
              );
            } else if (snapshot.hasError) {
              return Text('Xatolik: ${snapshot.error}');
            }
            principle = snapshot.data!.toList();
            return ListView.separated(
              itemCount: principle.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 0),
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                  title: Text(principle[index].name!),
                  // subtitle: Text('Trailing expansion arrow icon'),
                  children: <Widget>[
                    ListTile(title: Text(principle[index].reference!)),
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
