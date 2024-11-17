import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/infrastructure/apis/grade_service.dart';
import 'package:language/presentation/views/adder_view/grade_add_view.dart';
import 'package:language/presentation/widgets/grade_list_widget.dart';

class GradeListView extends StatelessWidget {
  final String category;
  const GradeListView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    List<GradeModel> gradeList = [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: black,
          ),
        ),
        backgroundColor: Colors.blueAccent.shade400,
        actions: [
          if (category.compareTo("Grade") == 0) ...[
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GradeAddView(id: -1),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: black,
                size: 28,
              ),
            ),
          ],
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: FutureBuilder(
          future: GradeService().fetchGradeByCategory(category),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CupertinoActivityIndicator(
                radius: 15.0,
                color: blue,
              );
            } else if (snapshot.hasError) {
              return Text('Xatolik: ${snapshot.error}');
            }
            gradeList = snapshot.data!.toList();
            return ListView.separated(
              itemCount: gradeList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) =>
                  GradeListWidget(grade: gradeList[index], category: category),
            );
          },
        ),
      ),
    );
  }
}
