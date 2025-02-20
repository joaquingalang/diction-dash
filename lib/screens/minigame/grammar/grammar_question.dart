import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/progress_bars/countdown_bar.dart';
import 'package:diction_dash/widgets/buttons/oval_button.dart';

class GrammarQuestion extends StatefulWidget {
  const GrammarQuestion({
    super.key,
    required this.phrase,
    required this.isCorrect,
    required this.onAnswer,
  });

  final String phrase;
  final bool isCorrect;
  final VoidCallback onAnswer;

  @override
  State<GrammarQuestion> createState() => _GrammarQuestionState();
}

class _GrammarQuestionState extends State<GrammarQuestion> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Countdown Bar
          CountdownBar(
            isStopped: false,
            onTimerComplete: () {
              print('Timer Complete!');
            },
          ),

          // Grammar Minigame Instructions
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: kSubtext20,
              children: [
                TextSpan(
                  text: 'Identify if the sentence\nis ',
                ),
                TextSpan(
                    text: 'grammatically correct.', style: kFontWeightBold),
              ],
            ),
          ),

          // Offset
          SizedBox(height: 30),

          // Grammar Question
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              widget.phrase,
              style: kSubtext20,
              textAlign: TextAlign.center,
            ),
          ),

          // Offset
          SizedBox(height: 30),

          // Choices
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                OvalButton(
                  onPressed: () => widget.onAnswer,
                  child: Center(
                    child: Text('CORRECT', style: kButtonTextStyle),
                  ),
                ),
                OvalButton(
                  color: Colors.white,
                  borderColor: kOrangeColor600,
                  onPressed: () => widget.onAnswer,
                  child: Center(
                    child: Text('INCORRECT', style: kOrangeButtonTextStyle),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}