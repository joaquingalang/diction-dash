import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/services/game_audio.dart';
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
  final Function(bool) onAnswer;

  @override
  State<GrammarQuestion> createState() => _GrammarQuestionState();
}

class _GrammarQuestionState extends State<GrammarQuestion> {

  // Game Audio
  final GameAudio _gameAudio = GameAudio();

  // Question State Data
  bool _isAnswered = false;
  List<Color> buttonColors = [kOrangeColor600, Colors.white];
  TextStyle incorrectButtonTextStyle = kOrangeButtonTextStyle;

  void _resetQuestion() {
    setState(() {
      _isAnswered = false;
      buttonColors = [kOrangeColor600, Colors.white];
      incorrectButtonTextStyle = kOrangeButtonTextStyle;
    });
  }

  void _questionTimeout() async {
    if (!_isAnswered) {
      if (widget.isCorrect) {
        setState(() {
          _isAnswered = true;
          buttonColors[0] = Colors.red;
        });
      } else {
        setState(() {
          _isAnswered = true;
          buttonColors[1] = Colors.red;
          incorrectButtonTextStyle = kButtonTextStyle;
        });
      }
      _gameAudio.incorrectAnswer();
      await Future.delayed(Duration(seconds: 2));
      _resetQuestion();
      bool incorrectAnswer = !widget.isCorrect;
      widget.onAnswer(incorrectAnswer);
    }
  }

  void _playAnswerSound(bool answer) {
    if (answer == widget.isCorrect) {
      _gameAudio.correctAnswer();
    } else {
      _gameAudio.incorrectAnswer();
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
                  onPressed: () async {
                    if (!_isAnswered) {
                      setState(() {
                        _isAnswered = true;
                        buttonColors[0] = (true == widget.isCorrect) ? Colors.green : Colors.red;
                      });
                      _playAnswerSound(true);
                      await Future.delayed(Duration(seconds: 2));
                      _resetQuestion();
                      widget.onAnswer(true);
                    }
                  },
                  color: buttonColors[0],
                  child: Center(
                    child: Text('CORRECT', style: kButtonTextStyle),
                  ),
                ),
                OvalButton(
                  color: buttonColors[1],
                  borderColor: (buttonColors[1] == Colors.white) ? kOrangeColor600 : null,
                  onPressed: () async {
                    if (!_isAnswered) {
                      setState(() {
                        _isAnswered = true;
                        buttonColors[1] = (false == widget.isCorrect) ? Colors.green : Colors.red;
                        incorrectButtonTextStyle = kButtonTextStyle;
                      });
                      _playAnswerSound(false);
                      await Future.delayed(Duration(seconds: 2));
                      _resetQuestion();
                      widget.onAnswer(false);
                    }
                  },
                  child: Center(
                    child: Text('INCORRECT', style: incorrectButtonTextStyle),
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