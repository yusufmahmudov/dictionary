import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/infrastructure/apis/grade_service.dart';
import 'package:language/presentation/widgets/grade_detail_widget.dart';

class GradeView extends StatefulWidget {
  final String test;
  final int count;
  final String gradeName;
  const GradeView(
      {super.key,
      required this.test,
      required this.count,
      required this.gradeName});

  @override
  State<GradeView> createState() => _GradeViewState();
}

class _GradeViewState extends State<GradeView> {
  List<GradeModel> grade = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        title: Text(
          widget.gradeName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 26,
              color: black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: FutureBuilder(
          future: GradeService().fetchGradeByCategory(widget.gradeName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CupertinoActivityIndicator(
                radius: 15.0,
                color: blue,
              );
            } else if (snapshot.hasError) {
              return Text('Xatolik: ${snapshot.error}');
            } else if (snapshot.hasData) {
              grade = snapshot.data!.toList();
              return ListView.separated(
                itemCount: grade.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 12);
                },
                itemBuilder: (BuildContext context, int index) {
                  return GradeDetailWidget(
                    test: widget.test,
                    count: widget.count,
                    grade: grade[index],
                  );
                },
              );
            }
            return const CircularProgressIndicator.adaptive();
          },
        ),
      ),
    );
  }
}
