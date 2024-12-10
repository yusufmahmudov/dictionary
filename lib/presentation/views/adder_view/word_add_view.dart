import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language/application/word/word_bloc.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/data/g_model/word_model_g.dart';
import 'package:language/data/grade_model.dart';
import 'package:language/infrastructure/apis/word_service.dart';
import 'package:language/presentation/widgets/custom_text_field.dart';
import 'package:language/presentation/widgets/w_button.dart';
import 'package:language/utils/log_service.dart';

class WordAddView extends StatefulWidget {
  final GradeModel grade;
  const WordAddView({super.key, required this.grade});

  @override
  State<WordAddView> createState() => _WordAddViewState();
}

class _WordAddViewState extends State<WordAddView> {
  late TextEditingController controllerEn;
  late TextEditingController controllerUz;
  WordService wordService = WordService();
  List<WordModelG> words = [];

  @override
  void initState() {
    controllerEn = TextEditingController();
    controllerUz = TextEditingController();
    super.initState();
  }

  void _submitForm() {
    if (controllerEn.text.isNotEmpty && controllerUz.text.isNotEmpty) {
      words.add(
        WordModelG(
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
        child: BlocBuilder<WordBloc, WordState>(
          builder: (context, state) {
            return WButton(
              color: blue,
              height: 54,
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              text: "Save words",
              onTap: () {
                _submitForm();
                if (words.isNotEmpty) {
                  Log.i(words.map((e) => e.en));
                  context.read<WordBloc>().add(
                        CreateWordsEvent(
                          words: words,
                          grade: widget.grade,
                          onSuccess: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Words is empty")));
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
              "Add new words",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: black,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: words.length + 1,
                itemBuilder: (context, index) {
                  if (index == words.length) {
                    return _buildAddNewWordsRow();
                  }
                  return _buildWordsRow(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordsRow(int index) {
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
                hintText: words[index].en!,
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
                hintText: words[index].uz!,
                hintTextColor: black,
                borderColor: blue,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: () => _removeWords(index),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewWordsRow() {
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
                hintText: 'English word',
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
                hintText: 'Uzbek word',
                borderColor: blue,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: _addWord,
          ),
        ],
      ),
    );
  }

  void _removeWords(int index) {
    setState(() {
      words.removeAt(index);
    });
  }

  void _addWord() {
    if (controllerEn.text.isNotEmpty && controllerUz.text.isNotEmpty) {
      setState(() {
        words.add(
          WordModelG(
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
