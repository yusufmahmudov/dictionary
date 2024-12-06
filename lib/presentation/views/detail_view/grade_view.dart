import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:language/application/grade/grade_bloc.dart';
import 'package:language/assets/color/colors.dart';
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
  @override
  void initState() {
    context
        .read<GradeBloc>()
        .add(GetGradeByCategory(category: widget.gradeName));
    super.initState();
  }

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
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 26,
              color: white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 12);
              },
              itemBuilder: (BuildContext context, int index) {
                return GradeDetailWidget(
                  test: widget.test,
                  count: widget.count,
                  grade: state.grade[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
