// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/controller/home_controller.dart';

class scoreNumberWidget extends StatelessWidget {
  const scoreNumberWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, value, child) => Text(
        '${value.totalScore.toString()}/${value.questions.length}',
        style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      ),
    );
  }
}
