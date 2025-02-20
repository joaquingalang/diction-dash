import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/progress_bars/countdown_bar.dart';
import 'package:diction_dash/widgets/buttons/oval_button.dart';

class ComprehensionQuestion extends StatefulWidget {
  const ComprehensionQuestion({
    super.key,
    required this.paragraph,
    required this.question,
    required this.choices,
    required this.answer,
    required this.onAnswer,
  });

  final String paragraph;
  final String question;
  final List<String> choices;
  final String answer;
  final VoidCallback onAnswer;

  @override
  State<ComprehensionQuestion> createState() => _ComprehensionQuestionState();
}

class _ComprehensionQuestionState extends State<ComprehensionQuestion> {
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

          // Comprehension Minigame Instruction
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: kSubtext20,
              children: [
                TextSpan(text: 'Comprehend ', style: kFontWeightBold),
                TextSpan(
                    text: 'the sentence\nand answer the given question.'),
              ],
            ),
          ),

          // Offset
          SizedBox(height: 30),

          // Comprehension Question
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '${widget.paragraph}\n\n${widget.question}',
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
                  onPressed: widget.onAnswer,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(widget.choices[0], style: kButtonTextStyle),
                  ),
                ),
                OvalButton(
                  onPressed: widget.onAnswer,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(widget.choices[1], style: kButtonTextStyle),
                  ),
                ),
                OvalButton(
                  onPressed: widget.onAnswer,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(widget.choices[2], style: kButtonTextStyle),
                  ),
                ),
                OvalButton(
                  onPressed: widget.onAnswer,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
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