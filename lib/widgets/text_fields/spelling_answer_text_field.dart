import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';

class SpellingAnswerTextField extends StatelessWidget {
  const SpellingAnswerTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: controller,
        style: kSubtext24,
        cursorColor: kOrangeColor500,
        decoration: InputDecoration(
          hintText: 'Answer',
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 4, color: kOrangeColor600),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 4, color: kOrangeColor600),
          ),
          contentPadding: EdgeInsets.all(18),
        ),
      ),
    );
  }
}
