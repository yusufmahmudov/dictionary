import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/data/g_model/principle_model_g.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/infrastructure/apis/principle_service.dart';
import 'package:language/presentation/widgets/custom_text_field.dart';
import 'package:language/presentation/widgets/w_button.dart';

class PrincipleAddView extends StatefulWidget {
  final GradeModel grade;
  const PrincipleAddView({super.key, required this.grade});

  @override
  State<PrincipleAddView> createState() => _PrincipleAddViewState();
}

class _PrincipleAddViewState extends State<PrincipleAddView> {
  late TextEditingController controllerName;
  late TextEditingController controllerRef;
  PrincipleService principleService = PrincipleService();
  List<PrincipleModelG> principles = [];

  @override
  void initState() {
    controllerName = TextEditingController();
    controllerRef = TextEditingController();
    super.initState();
  }

  Future<void> _submitForm() async {
    if (controllerName.text.isNotEmpty && controllerRef.text.isNotEmpty) {
      principles.add(
        PrincipleModelG(
          name: controllerName.text,
          reference: controllerRef.text,
          gradeId: widget.grade.id,
        ),
      );
    }
    if (principles.isNotEmpty) {
      await principleService.addPrinciple(principles, widget.grade);
    }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        title: Text(
          "${widget.grade.name}",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: black,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        child: WButton(
          color: blue,
          height: 54,
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          text: "Save principle",
          onTap: () {
            _submitForm();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add new principle",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: black,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: principles.length + 1,
                itemBuilder: (context, index) {
                  if (index == principles.length) {
                    return _buildAddNewPrincipleRow();
                  }
                  return _buildPrincipleRow(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrincipleRow(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${index + 1}-principle",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () => _removePrinciple(index),
              ),
            ],
          ),
          CustomTextField(
            // readOnly: true,
            hintText: principles[index].name!,
            borderColor: greyBack.withOpacity(.8),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            maxLines: 3,
            expands: false,
            noHeight: true,
            minLines: 3,
            readOnly: true,
            hintText: principles[index].reference!,
            borderColor: greyBack.withOpacity(.8),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewPrincipleRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${principles.length + 1}-principle",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () => _addPrinciple(),
              ),
            ],
          ),
          CustomTextField(
            controller: controllerName,
            hintText: "Principle name",
            borderColor: greyBack.withOpacity(.8),
          ),
          const SizedBox(height: 8),
          CustomTextField(
            maxLines: 3,
            expands: false,
            noHeight: true,
            minLines: 3,
            controller: controllerRef,
            hintText: "Principle reference",
            borderColor: greyBack.withOpacity(.8),
          ),
        ],
      ),
    );
  }

  void _removePrinciple(int index) {
    setState(() {
      principles.removeAt(index);
    });
  }

  void _addPrinciple() {
    if (controllerName.text.isNotEmpty && controllerRef.text.isNotEmpty) {
      setState(() {
        principles.add(
          PrincipleModelG(
            name: controllerRef.text,
            reference: controllerName.text,
            gradeId: widget.grade.id,
          ),
        );
        controllerName.clear();
        controllerRef.clear();
      });
    }
  }
}
