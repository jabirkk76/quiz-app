import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/helpers/app_colors.dart';

class HomeController with ChangeNotifier {
  List<Icon> scoreTracker = [];
  int questionIndex = 0;
  int totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;
  int timeLeft = 15;
  bool cancelTimer = false;

  startCountDown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (cancelTimer == true) {
        // ignore: avoid_print
        print('jabir');
        timer.cancel();
        notifyListeners();
      } else if (timeLeft > 0) {
        notifyListeners();
        timeLeft--;
      }
    });
  }

  void cancelTimerr() {
    cancelTimer = true;
    notifyListeners();
  }

  resetQuiz() {
    questionIndex = 0;
    totalScore = 0;
    scoreTracker = [];
    endOfQuiz = false;
  }

  void nextQuestion() {
    cancelTimer = false;
    timeLeft = 15;
    startCountDown();
    notifyListeners();
    questionIndex++;

    answerWasSelected = false;
    correctAnswerSelected = false;
    notifyListeners();
    if (questionIndex >= questions.length) {
      resetQuiz();
    }
  }

  void navigateToPreviousScreen(BuildContext context) {
    Navigator.pop(context);
  }

  void questionAnswered(bool answerScore) {
    notifyListeners();
    answerWasSelected = true;
    if (answerScore) {
      totalScore++;
      correctAnswerSelected = true;
    }
    scoreTracker.add(answerScore
        ? Icon(
            Icons.check_circle,
            color: AppColors.green,
          )
        : Icon(
            Icons.clear,
            color: AppColors.red,
          ));
    if (questionIndex + 1 == questions.length) {
      endOfQuiz = true;
    }
    notifyListeners();
  }

  final questions = [
    {
      'question':
          'In which month does the German festival of Oktoberfest mostly take place?',
      'answers': [
        {'answerText': 'January', 'score': true},
        {'answerText': 'October', 'score': false},
        {'answerText': 'September', 'score': false}
      ]
    },
    {
      'question': 'ICAO stands for',
      'answers': [
        {
          'answerText': 'Indian Corporation of Agriculture Organization',
          'score': false
        },
        {
          'answerText': 'International Civil Aviation Organization',
          'score': true
        },
        {
          'answerText': 'Institute of Company of Accounts Organization',
          'score': false
        }
      ]
    },
    {
      'question': 'India has largest deposits of ____ in the world.',
      'answers': [
        {'answerText': 'gold', 'score': true},
        {'answerText': 'copper', 'score': false},
        {'answerText': 'mica', 'score': true}
      ]
    },
    {
      'question': 'How many Lok Sabha seats belong to Rajasthan?',
      'answers': [
        {'answerText': '32', 'score': false},
        {'answerText': '25', 'score': true},
        {'answerText': '30', 'score': false}
      ]
    },
    {
      'question':
          'In which year of First World War Germany declared war on Russia and France?',
      'answers': [
        {'answerText': '1914', 'score': true},
        {'answerText': '1915', 'score': false},
        {'answerText': '1916', 'score': false}
      ]
    },
    {
      'question':
          'First Indian Technicolor film ____ in the early 1950s was produced by ____',
      'answers': [
        {'answerText': 'Jhansi Ki Rani, Sir Syed Ahmed', 'score': false},
        {'answerText': 'Jhansi Ki Rani, Sohrab Modi', 'score': true},
        {'answerText': 'Mirza Ghalib, Munshi Premchand', 'score': false}
      ]
    },
    {
      'question':
          'Grand Central Terminal, Park Avenue, New York is the world\'s',
      'answers': [
        {'answerText': 'largest railway station', 'score': true},
        {'answerText': 'highest railway station', 'score': false},
        {'answerText': 'longest railway station', 'score': false}
      ]
    },
    {
      'question': 'Entomology is the science that studies',
      'answers': [
        {'answerText': 'Behavior of human beings', 'score': false},
        {'answerText': 'Insects', 'score': true},
        {'answerText': 'The formation of rocks', 'score': false}
      ]
    },
    {
      'question':
          'For which of the following disciplines is Nobel Prize awarded?',
      'answers': [
        {'answerText': 'All of the above', 'score': true},
        {'answerText': 'Physiology or Medicine', 'score': false},
        {'answerText': 'Literature, Peace and Economics', 'score': false}
      ]
    },
    {
      'question': 'Where is the Judicature of Orissa?',
      'answers': [
        {'answerText': 'Both', 'score': false},
        {'answerText': 'Cuttack', 'score': true},
        {'answerText': 'Bhubaneswar', 'score': false}
      ]
    },
  ];
}
