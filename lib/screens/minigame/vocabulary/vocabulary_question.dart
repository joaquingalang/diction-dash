import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/progress_bars/countdown_bar.dart';
import 'package:diction_dash/widgets/buttons/oval_button.dart';


class VocabularyQuestion extends StatefulWidget {
  const VocabularyQuestion({
    super.key,
    required this.word,
    required this.choices,
    required this.answer,
    required this.onAnswer,
  });

  final String word;
  final List<String> choices;
  final String answer;
  final VoidCallback onAnswer;

  @override
  State<VocabularyQuestion> createState() => _VocabularyQuestionState();
}

class _VocabularyQuestionState extends State<VocabularyQuestion> {
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

          // Vocabulary Minigame Instructions
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: kSubtext20,
              children: [
                TextSpan(
                  text: 'Select the appropriate',
                ),
                TextSpan(
                  text: '\nsynonym.',
                  style: kFontWeightBold,
                ),
              ],
            ),
          ),

          // Offset
          SizedBox(height: 30),

          // Provided Word
          Text(
            widget.word,
            style: kOswaldLarge,
            textAlign: TextAlign.center,
          ),

          // Offset
          SizedBox(height: 30),

          // Choices
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                OvalButton(
                  onPressed: () {},
                  child: Center(
                    child: Text(widget.choices[0], style: kButtonTextStyle),
                  ),
                ),
                OvalButton(
                  onPressed: () {},
                  child: Center(
                    child: Text(widget.choices[1], style: kButtonTextStyle),
                  ),
                ),
                OvalButton(
                  onPressed: () {},
                  child: Center(
                    child: Text(widget.choices[2], style: kButtonTextStyle),
                  ),
                ),
                OvalButton(
                  onPressed: () {},
                  child: Center(
                    child: Text(widget.choices[3], style: kButtonTextStyle),
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