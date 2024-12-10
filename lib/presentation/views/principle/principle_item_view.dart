import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:language/application/principle/principle_bloc.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/data/grade_model.dart';

class PrincipleItemView extends StatelessWidget {
  final GradeModel grade;
  const PrincipleItemView({super.key, required this.grade});

  @override
  Widget build(BuildContext context) {
    context.read<PrincipleBloc>().add(GetPrincipleByGrade(gradeId: grade.id!));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        title: Text(
          grade.name!,
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: BlocBuilder<PrincipleBloc, PrincipleState>(
          builder: (context, state) {
            if (state.statusPrinciple.isInProgress) {
              return const CupertinoActivityIndicator(
                radius: 15.0,
                color: blue,
              );
            } else if (state.principle.isEmpty) {
              return const Center(
                child: Text(
                  "Grade is empty",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              );
            }
            return ListView.separated(
              itemCount: state.principle.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 0),
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                  title: Text(state.principle[index].name!),
                  // subtitle: Text('Trailing expansion arrow icon'),
                  children: <Widget>[
                    ListTile(title: Text(state.principle[index].reference!)),
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
