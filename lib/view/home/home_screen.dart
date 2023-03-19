// ignore_for_file: unused_local_variable, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controller/home_controller.dart';
import 'package:quiz_app/helpers/app_colors.dart';
import 'package:quiz_app/view/home/widget/answers_widget.dart';
import 'package:quiz_app/view/home/widget/final_result_widget.dart';
import 'package:quiz_app/view/home/widget/score_number_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeController>(context, listen: false).startCountDown();
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('QUIZ APP'),
          backgroundColor: AppColors.primaryColor),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Consumer<HomeController>(
              builder: (context, value, child) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        value.timeLeft.toString(),
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: AppColors.green),
                      ),
                      if (value.scoreTracker.length == 0)
                        const SizedBox(
                          height: 25,
                        ),
                      if (value.scoreTracker.length > 0) ...value.scoreTracker,
                      const scoreNumberWidget(),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      width: double.infinity,
                      height: 130,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primaryColor),
                      child: Center(
                        child: Text(
                          value.questions[value.questionIndex]['question']
                              .toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ...(value.questions[value.questionIndex]['answers']
                          as List<Map>)
                      .map(
                    (answers) => AnswersWidget(
                        answerText: answers['answerText'].toString(),
                        answerTap: () {
                          if (value.answerWasSelected) {
                            return;
                          }
                          value.cancelTimerr();
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                color: value.correctAnswerSelected
                                    ? AppColors.green
                                    : AppColors.red,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        value.correctAnswerSelected
                                            ? 'Well done,you got it right!'
                                            : 'Wrong!',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.whiteColor),
                                      ),
                                      CircleAvatar(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          child: TextButton(
                                              onPressed: () {
                                                homeController
                                                    .navigateToPreviousScreen(
                                                        context);
                                              },
                                              child: Text(
                                                'OK',
                                                style: TextStyle(
                                                    color:
                                                        AppColors.whiteColor),
                                              )))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                          value.questionAnswered(answers['score']);
                        },
                        answerColor: value.answerWasSelected
                            ? answers['score']
                                ? AppColors.green
                                : AppColors.red
                            : Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: AppColors.primaryColor,
                            minimumSize: const Size(double.infinity, 50)),
                        onPressed: () {
                          if (value.answerWasSelected == false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please select an answer befor going to next question')));
                            return;
                          }
                          value.nextQuestion();
                        },
                        child: Text(value.endOfQuiz
                            ? 'Restart Quiz'
                            : 'Next Question')),
                  ),
                  if (value.answerWasSelected && value.endOfQuiz == true)
                    if (value.endOfQuiz)
                      final_result_widget(totalScore: value.totalScore)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
