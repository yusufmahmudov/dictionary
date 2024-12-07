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

    Future.delayed(const Duration(seconds: 2), () {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: white,
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

                  Expanded(
                    child: ListView.builder(
                      itemCount: question[currentQuestionIndex].options.length,
                      itemBuilder: (context, index) {
                        String char = ["A", "B", "C", "D"][index];

                        final option =
                            question[currentQuestionIndex].options[index];

                        Color backgroundColor = white;
                        Color borderColor = grayLight;
                        Icon icon = const Icon(
                          Icons.circle_outlined,
                          size: 24,
                          color: Color.fromARGB(255, 199, 199, 199),
                        );
                        if (hasAnswered) {
                          if (index ==
                              question[currentQuestionIndex].answerIndex) {
                            backgroundColor = const Color.fromARGB(
                                255, 149, 247, 152); // Correct answer
                            icon = const Icon(
                              Icons.check_circle,
                              size: 24,
                              color: Colors.green,
                            );
                            borderColor = green;
                          } else if (index == selectedAnswerIndex) {
                            backgroundColor = const Color.fromARGB(255, 253,
                                144, 136); // Incorrect selected answer
                            icon = const Icon(
                              Icons.cancel,
                              size: 24,
                              color: red,
                            );
                            borderColor = red;
                          }
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 6.0),
                          child: InkWell(
                            onTap:
                                hasAnswered ? null : () => checkAnswer(index),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                border:
                                    Border.all(color: borderColor, width: 2),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.elliptical(30, 30),
                                  topRight: Radius.elliptical(3, 3),
                                  bottomLeft: Radius.elliptical(3, 3),
                                  bottomRight: Radius.elliptical(30, 30),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      char,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          option,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    icon
                                  ],
                                ),
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
    for (int j = 0; j < 4; j++) {
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

  Widget checkIconWidget(bool hasAnswered, int index) {
    if (hasAnswered) {
      if (index == question[currentQuestionIndex].answerIndex) {
        return const Icon(Icons.check_circle);
      } else if (index == selectedAnswerIndex) {
        return const Icon(Icons.cancel);
      }
    }
    return const Icon(Icons.circle_outlined);
  }
}
