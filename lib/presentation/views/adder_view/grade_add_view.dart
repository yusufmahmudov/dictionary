import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language/application/grade/grade_bloc.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/data/g_model/grade_model_g.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/infrastructure/apis/grade_service.dart';
import 'package:language/presentation/widgets/custom_text_field.dart';
import 'package:language/presentation/widgets/w_button.dart';

class GradeAddView extends StatefulWidget {
  final GradeModel grade;
  final int index;
  const GradeAddView({super.key, required this.grade, required this.index});

  @override
  State<GradeAddView> createState() => _GradeAddViewState();
}

class _GradeAddViewState extends State<GradeAddView> {
  TextEditingController controllerGrade = TextEditingController();

  bool success = false;
  String? categorySelectedVal;
  final GradeService gradeService = GradeService();

  @override
  void initState() {
    super.initState();
  }

  static const menuItems = <String>[
    'Words',
    'Phrases',
    'Principle',
  ];

  final List<DropdownMenuItem<String>> dropDownMenuItem = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        title: Text(
          widget.grade.id != null ? widget.grade.name! : "New Grade",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: black,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<GradeBloc, GradeState>(
          builder: (context, state) {
            return WButton(
              color: blue,
              height: 54,
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              text: "Save grade",
              onTap: () {
                if (controllerGrade.text.isNotEmpty &&
                    categorySelectedVal!.isNotEmpty) {
                  if (widget.grade.id != null) {
                    context.read<GradeBloc>().add(
                          UpdateGradeEvent(
                            index: widget.index,
                            grade: GradeModel(
                              id: widget.grade.id,
                              name: controllerGrade.text,
                              success: widget.grade.success,
                              category: categorySelectedVal,
                              count: widget.grade.count,
                            ),
                            onSuccess: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                  } else {
                    context.read<GradeBloc>().add(
                          CreateGradeEvent(
                            grade: GradeModelG(
                              name: controllerGrade.text,
                              category: categorySelectedVal,
                              count: 0,
                              success: false,
                            ),
                            onSuccess: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fill them all")));
                }
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: controllerGrade,
              title: "Grade name",
              hintText: "Name",
              borderColor: blue,
            ),
            const SizedBox(height: 12),
            const Text(
              "Select a category",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              items: dropDownMenuItem,
              value: categorySelectedVal,
              hint: const Text(
                "Category",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    categorySelectedVal = newValue;
                  });
                }
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: blue),
                ),
              ),
              icon: const Icon(Icons.arrow_drop_down),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
