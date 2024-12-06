import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:language/application/grade/grade_bloc.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/presentation/widgets/grade_list_category_widget.dart';

class GradeListCategory extends StatefulWidget {
  final String category;

  const GradeListCategory({super.key, required this.category});

  @override
  State<GradeListCategory> createState() => _GradeListCategoryState();
}

class _GradeListCategoryState extends State<GradeListCategory> {
  @override
  void initState() {
    context
        .read<GradeBloc>()
        .add(GetGradeByCategory(category: widget.category));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: white,
          ),
        ),
        backgroundColor: Colors.blueAccent.shade400,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        child: BlocBuilder<GradeBloc, GradeState>(
          builder: (context, state) {
            if (state.statusGrade.isInProgress) {
              return const CupertinoActivityIndicator(
                radius: 15.0,
                color: blue,
              );
            } else if (state.grade.isEmpty) {
              return const Center(
                child: Text(
                  "Grade is empty",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              );
            }
            state.grade.sort(
                (a, b) => a.success.toString().compareTo(b.success.toString()));

            return ListView.separated(
              itemCount: state.grade.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) =>
                  GradeListCategoryWidget(grade: state.grade[index]),
            );
          },
        ),
      ),
    );
  }
}
