import 'dart:math';

import 'package:flutter/material.dart';
import 'package:language/assets/color/colors.dart';
import 'package:language/data/question.dart';

class EnTestView extends StatefulWidget {
  final String test;
  final int count;
  final List<Question> list;
  const EnTestView({
    super.key,
    required this.test,
    required this.count,
    required this.list,
  });

  @override
  State<EnTestView> createState() => _EnTestViewState();
}

class _EnTestViewState extends State<EnTestView> {
  late List<Question> question;
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int falseAnswers = 0;
  bool hasAnswered = false;
  int? selectedAnswerIndex;
  List<bool> answeredQuestions = [];

  @override
  void initState() {
    super.initState();
    question = [];
    for (var q in widget.list) {
      int i = Random().nextInt(3);
      question.add(
        Question(
          uz: q.uz,
          en: q.en,
          question: q.en,
          answerIndex: i,
          options: randomOptions(i, q.uz),
        ),
      );
    }
    answeredQuestions = List.generate(widget.count, (index) => false);
  }

  void checkAnswer(int selectedIndex) {
    if (hasAnswered) return;

    setState(() {
      selectedAnswerIndex = selectedIndex;
      hasAnswered = true;
      answeredQuestions[currentQuestionIndex] = true;

      if (selectedIndex == question[currentQuestionIndex].answerIndex) {
        correctAnswers++;
      } else {
        falseAnswers++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (currentQuestionIndex < widget.count - 1) {
        setState(() {
          currentQuestionIndex++;
          hasAnswered = false;
          selectedAnswerIndex = null;
        });
      } else {
        showResults();
      }
    });
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

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      correctAnswers = 0;
      falseAnswers = 0;
      hasAnswered = false;
      selectedAnswerIndex = null;
      answeredQuestions = List.generate(widget.count, (index) => false);
    });
  }

  // Color getButtonColor(int index) {
  //   setState(() {
  //     if (hasAnswered) {
  //       if (selectedAnswerIndex == index) {
  //         _buttonColor = index == question[currentQuestionIndex].answerIndex
  //             ? Colors.green
  //             : Colors.red;
  //       }
  //       if (index == question[currentQuestionIndex].answerIndex) {
  //         _buttonColor = Colors.green;
  //       }
  //     }

  //     _buttonColor = Theme.of(context).colorScheme.onPrimary;
  //   });
  //   return _buttonColor;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade400,
        title: Text(
          "Question ${currentQuestionIndex + 1}/${widget.count}",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: black,
          ),
        ),
        centerTitle: true,
      ),
      body: question.isEmpty
          ? const Text(
              "Question is Empty",
              style: TextStyle(fontSize: 24),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Progress indicator
                  LinearProgressIndicator(
                    value: (currentQuestionIndex + 1) / widget.count,
                    backgroundColor: Colors.grey[200],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                  const SizedBox(height: 32),

                  // Question
                  Card(
                    elevation: 2,
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
                  const SizedBox(height: 32),

                  // Options
                  Expanded(
                    child: ListView.builder(
                      itemCount: question[currentQuestionIndex].options.length,
                      itemBuilder: (context, index) {
                        final option =
                            question[currentQuestionIndex].options[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: ElevatedButton(
                            onPressed:
                                hasAnswered ? null : () => checkAnswer(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 16,
                                color: hasAnswered &&
                                        (selectedAnswerIndex == index ||
                                            question[currentQuestionIndex]
                                                    .answerIndex ==
                                                index)
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
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
                ],
              ),
            ),
    );
  }

  List<String> randomOptions(int i, String uz) {
    List<String> options = [];
    for (int j = 0; j < 3; j++) {
      String t = "";
      if (j == i) {
        options.add(uz);
        continue;
      }
      do {
        t = widget.list[Random().nextInt(widget.count)].uz;
      } while (uz.compareTo(t) == 0 || options.contains(t));
      options.add(t);
    }

    return options;
  }
}
