import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language/application/phrase/phrase_bloc.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/data/g_model/phrase_model_g.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/infrastructure/apis/phrase_service.dart';
import 'package:language/presentation/widgets/custom_text_field.dart';
import 'package:language/presentation/widgets/w_button.dart';

class PhraseAddView extends StatefulWidget {
  final GradeModel grade;
  const PhraseAddView({super.key, required this.grade});

  @override
  State<PhraseAddView> createState() => _PhraseAddViewState();
}

class _PhraseAddViewState extends State<PhraseAddView> {
  late TextEditingController controllerEn;
  late TextEditingController controllerUz;
  PhraseService phraseService = PhraseService();
  List<PhraseModelG> phrase = [];

  @override
  void initState() {
    controllerEn = TextEditingController();
    controllerUz = TextEditingController();
    super.initState();
  }

  Future<void> _submitForm() async {
    if (controllerEn.text.isNotEmpty && controllerUz.text.isNotEmpty) {
      phrase.add(
        PhraseModelG(
          en: controllerEn.text,
          uz: controllerUz.text,
          gradeId: widget.grade.id,
        ),
      );
    }
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
        child: BlocBuilder<PhraseBloc, PhraseState>(
          builder: (context, state) {
            return WButton(
              color: blue,
              height: 54,
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              text: "Save phrases",
              onTap: () {
                _submitForm();
                if (phrase.isNotEmpty) {
                  context.read<PhraseBloc>().add(
                        CreatePhraseEvent(
                          phrase: phrase,
                          grade: widget.grade,
                          onSuccess: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Phrase is empty")));
                  Navigator.pop(context);
                }
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add new phrases",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: black,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: phrase.length + 1,
                itemBuilder: (context, index) {
                  if (index == phrase.length) {
                    return _buildAddNewPhraseRow();
                  }
                  return _buildPhraseRow(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhraseRow(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 48,
              child: CustomTextField(
                // readOnly: true,
                hintText: phrase[index].en!,
                hintTextColor: black,
                borderColor: blue,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 48,
              child: CustomTextField(
                // readOnly: true,
                hintText: phrase[index].uz!,
                hintTextColor: black,
                borderColor: blue,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () => _removePhrase(index),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewPhraseRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 48,
              child: CustomTextField(
                controller: controllerEn,
                hintText: 'English phrase',
                borderColor: blue,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 48,
              child: CustomTextField(
                controller: controllerUz,
                hintText: 'Uzbek phrase',
                borderColor: blue,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: _addPhrase,
          ),
        ],
      ),
    );
  }

  void _removePhrase(int index) {
    setState(() {
      phrase.removeAt(index);
    });
  }

  void _addPhrase() {
    if (controllerEn.text.isNotEmpty && controllerUz.text.isNotEmpty) {
      setState(() {
        phrase.add(
          PhraseModelG(
            uz: controllerUz.text,
            en: controllerEn.text,
            gradeId: widget.grade.id,
          ),
        );
        controllerEn.clear();
        controllerUz.clear();
      });
    }
  }
}
