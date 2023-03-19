// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:quiz_app/helpers/app_colors.dart';

class final_result_widget extends StatelessWidget {
  const final_result_widget({
    super.key,
    required this.totalScore,
  });

  final int totalScore;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.black,
      child: Center(
        child: Text(
          totalScore > 4
              ? 'Congratulations! Your final score is: $totalScore'
              : 'Your final score is: $totalScore.\nBetter luck next time',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: totalScore > 4 ? Colors.green : AppColors.whiteColor),
        ),
      ),
    );
  }
}
