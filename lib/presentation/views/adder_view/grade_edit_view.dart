import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language/application/grade/grade_bloc.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/presentation/widgets/custom_text_field.dart';
import 'package:language/presentation/widgets/w_button.dart';

class GradeEditView extends StatefulWidget {
  final GradeModel grade;
  final int index;
  const GradeEditView({super.key, required this.grade, required this.index});

  @override
  State<GradeEditView> createState() => _GradeEditViewState();
}

class _GradeEditViewState extends State<GradeEditView> {
  TextEditingController controllerGrade = TextEditingController();
  late bool success;
  String? categorySelectedVal;
  String? successSelectedVal;

  @override
  void initState() {
    controllerGrade = TextEditingController(text: widget.grade.name);
    categorySelectedVal = widget.grade.category!;
    successSelectedVal = widget.grade.success! ? 'Done' : 'Not done';
    success = widget.grade.success!;
    super.initState();
  }

  @override
  void dispose() {
    controllerGrade.dispose();
    super.dispose();
  }

  static const menuItems = <String>[
    'Words',
    'Phrases',
    'Principle',
  ];

  static const menuSuccess = <String>[
    'Not done',
    'Done',
  ];

  final List<DropdownMenuItem<String>> dropDownMenuSuccess = menuSuccess
      .map(
        (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )),
      )
      .toList();

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
          widget.grade.name!,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: white,
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<GradeBloc, GradeState>(
          builder: (context, state) {
            return WButton(
              color: blue,
              height: 54,
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              text: "Update grade",
              onTap: () {
                if (controllerGrade.text.isNotEmpty &&
                    categorySelectedVal!.isNotEmpty) {
                  context.read<GradeBloc>().add(
                        UpdateGradeEvent(
                          index: widget.index,
                          grade: GradeModel(
                            id: widget.grade.id,
                            name: controllerGrade.text,
                            success: success,
                            category: categorySelectedVal,
                            count: widget.grade.count,
                          ),
                          onSuccess: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      );
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
              hint: Text(
                categorySelectedVal!,
                style: const TextStyle(
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
            const Text(
              "Select a success?",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              items: dropDownMenuSuccess,
              value: successSelectedVal,
              hint: Text(
                successSelectedVal!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    successSelectedVal = newValue;
                    successSelectedVal == 'Done'
                        ? success = true
                        : success = false;
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
          ],
        ),
      ),
    );
  }
}
