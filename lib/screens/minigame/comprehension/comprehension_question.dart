import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/services/game_audio.dart';
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
  final List choices;
  final String answer;
  final Function(String) onAnswer;

  @override
  State<ComprehensionQuestion> createState() => _ComprehensionQuestionState();
}

class _ComprehensionQuestionState extends State<ComprehensionQuestion> {

  // Game Audio
  final GameAudio _gameAudio = GameAudio();

  // Question State Data
  bool _isAnswered = false;
  List<Color> buttonColors = [
    kOrangeColor600,
    kOrangeColor600,
    kOrangeColor600,
    kOrangeColor600
  ];

  // Play Answer Sound
  void _playAnswerSound(String answer) {
    if (answer == widget.answer) {
      _gameAudio.correctAnswer();
    } else {
      _gameAudio.incorrectAnswer();
    }
  }

  // Marks Question As Incorrect After Countdown
  void _questionTimeout() async {
    if (!_isAnswered) {
      setState(() {
        _isAnswered = true;
        buttonColors[widget.choices.indexOf(widget.answer)] = Colors.red;
      });
      _gameAudio.incorrectAnswer();
      await Future.delayed(Duration(seconds: 2));
      _resetQuestion();
      widget.onAnswer('');
    }
  }

  // Resets Question Properties
  void _resetQuestion() {
    setState(() {
      _isAnswered = false;
      buttonColors = [
        kOrangeColor600,
        kOrangeColor600,
        kOrangeColor600,
        kOrangeColor600
      ];
    });
  }

  Future<void> _selectChoice(int choiceIndex) async {
    if (!_isAnswered) {
      setState(() {
        _isAnswered = true;
        buttonColors[choiceIndex] = (widget.answer == widget.choices[choiceIndex]) ? Colors.green : Colors.red;
        buttonColors[widget.choices.indexOf(widget.answer)] = Colors.green;
      });
      _playAnswerSound(widget.choices[choiceIndex]);
      await Future.delayed(Duration(seconds: 2));
      _resetQuestion();
      widget.onAnswer(widget.choices[choiceIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          // Countdown Bar
          CountdownBar(
            isStopped: _isAnswered,
            onTimerComplete: _questionTimeout,
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
                  onPressed: () => _selectChoice(0),
                  color: buttonColors[0],
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(widget.choices[0], style: kButtonTextStyle),
                  ),
                ),
                OvalButton(
                  onPressed: () => _selectChoice(1),
                  color: buttonColors[1],
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(widget.choices[1], style: kButtonTextStyle),
                  ),
                ),
                OvalButton(
                  onPressed: () => _selectChoice(2),
                  color: buttonColors[2],
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(widget.choices[2], style: kButtonTextStyle),
                  ),
                ),
                OvalButton(
                  onPressed: () => _selectChoice(3),
                  color: buttonColors[3],
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