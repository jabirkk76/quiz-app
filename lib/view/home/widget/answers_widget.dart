// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AnswersWidget extends StatelessWidget {
  AnswersWidget(
      {super.key,
      required this.answerText,
      required this.answerColor,
      required this.answerTap});
  final String answerText;
  final Color answerColor;
  void Function()? answerTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            color: answerColor,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          answerText,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
