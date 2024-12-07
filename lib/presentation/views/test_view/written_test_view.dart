import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/data/question.dart';
import 'package:language/presentation/widgets/custom_text_field.dart';

class WrittenTestView extends StatefulWidget {
  final String test;
  final int count;
  final List<Question> list;
  const WrittenTestView(
      {super.key, required this.test, required this.count, required this.list});

  @override
  State<WrittenTestView> createState() => _WrittenTestViewState();
}

class _WrittenTestViewState extends State<WrittenTestView> {
  Color backgroundColor = Colors.blueAccent.shade200;
  late TextEditingController controller;
  late List<Question> question;
  int currentQuestionIndex = 0;
  int falseAnswers = 0;
  int correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    question = [];
    for (var q in widget.list) {
      question.add(
        Question(
          uz: q.uz,
          en: q.en,
          question: q.uz,
          options: [],
          answerIndex: 0,
        ),
      );
    }
  }

  void showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Results'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('You got $correctAnswers out of ${widget.count} correct!'),
              const SizedBox(height: 20),
              Text(
                'Accuracy: ${(correctAnswers / widget.count * 100).toStringAsFixed(1)}%',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetQuiz();
              },
              child: const Text('Play Again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  void checkAnswer(String answer) {
    if (answer.isEmpty) return;
    setState(() {
      if (answer.toLowerCase() ==
          question[currentQuestionIndex].en.toLowerCase()) {
        correctAnswers++;
        backgroundColor = Colors.green;
      } else {
        falseAnswers++;
        backgroundColor = Colors.red;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (currentQuestionIndex < widget.count - 1) {
        setState(() {
          currentQuestionIndex++;
          controller = TextEditingController();
          backgroundColor = Colors.blueAccent.shade200;
        });
      } else {
        showResults();
      }
    });
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      correctAnswers = 0;
      falseAnswers = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        title: Text(
          "Question ${currentQuestionIndex + 1}/${widget.count}",
          style: const TextStyle(
            fontSize: 22,
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22.0),
        child: RichText(
          text: TextSpan(
            text: 'Score: $correctAnswers/',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: black,
            ),
            children: [
              TextSpan(
                text: "$falseAnswers",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: red,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: question.isEmpty
          ? const Text(
              "Question is Empty",
              style: TextStyle(fontSize: 24),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LinearProgressIndicator(
                    value: (currentQuestionIndex + 1) / widget.count,
                    backgroundColor: Colors.grey[200],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: borderColor, width: 2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.elliptical(30, 30),
                        topRight: Radius.elliptical(3, 3),
                        bottomLeft: Radius.elliptical(3, 3),
                        bottomRight: Radius.elliptical(30, 30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        question[currentQuestionIndex].en,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      CustomTextField(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        controller: controller,
                        hintText: "Answer",
                        borderColor: blue,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        child: InkWell(
                          onTap: () => checkAnswer(controller.text),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            height: 56,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
