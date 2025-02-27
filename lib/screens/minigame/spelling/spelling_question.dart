import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:diction_dash/services/game_audio.dart';
import 'package:diction_dash/widgets/progress_bars/countdown_bar.dart';
import 'package:diction_dash/widgets/text_fields/spelling_answer_text_field.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';

class SpellingQuestion extends StatefulWidget {
  const SpellingQuestion({
    super.key,
    required this.word,
    required this.definition,
    required this.onAnswer,
  });

  final String word;
  final String definition;
  final Function(String) onAnswer;

  @override
  State<SpellingQuestion> createState() => _SpellingQuestionState();
}

class _SpellingQuestionState extends State<SpellingQuestion> {

  // Spelling Answer Text Editing Controller
  final TextEditingController _spellingAnswerController = TextEditingController();

  // Text To Speech
  final FlutterTts _flutterTts = FlutterTts();

  // Game Audio
  final GameAudio _gameAudio = GameAudio();

  // Question State Data
  bool _isAnswered = false;
  String? result;
  Color buttonColor = kOrangeColor600;

  Future<void> _initFlutterTts() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setPitch(1);
    await _flutterTts.setSpeechRate(0.5);
  }

  Future<void> _speakWord(String word) async {
    if (word.isNotEmpty) {
      print(word);
      await _flutterTts.speak(word);
    }
  }

  // Play Answer Sound
  void _playAnswerSound(String answer) {
    if (answer == widget.word) {
      _gameAudio.correctAnswer();
    } else {
      _gameAudio.incorrectAnswer();
    }
  }

  // Resets Question Properties
  void _resetQuestion() {
    setState(() {
      _spellingAnswerController.text = '';
      _isAnswered = false;
      result = null;
      buttonColor = kOrangeColor600;
    });
  }

  // Marks Question As Incorrect After Countdown
  void _questionTimeout() async {
    if (!_isAnswered) {
      setState(() {
        _isAnswered = true;
        buttonColor = Colors.red;
        result = 'Wrong';
      });
      _gameAudio.incorrectAnswer();
      await Future.delayed(Duration(seconds: 2));
      _resetQuestion();
      widget.onAnswer('');
    }
  }

  @override
  void initState() {
    super.initState();
    _initFlutterTts();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      // Builder used to get max appbar height and subtract it from screen height
      // This difference is used to set a scrollable fixed body height
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                Scaffold.of(context).appBarMaxHeight! - 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Countdown Bar
                CountdownBar(
                  durationInSeconds: 20,
                  isStopped: _isAnswered,
                  onTimerComplete: _questionTimeout,
                ),

                // Spelling Minigame Instructions
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: kSubtext20,
                    children: [
                      TextSpan(
                        text: 'Spell',
                        style: kFontWeightBold,
                      ),
                      TextSpan(
                        text: ' the following word:\n',
                      ),
                      TextSpan(
                          text: (_isAnswered) ? widget.word : ('_ ' * widget.word.length).trim(),
                          style: kHiddenWordTextStyle),
                    ],
                  ),
                ),

                // Offset
                SizedBox(height: 30),

                // Definition Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    widget.definition,
                    style: kSubtext20,
                    textAlign: TextAlign.center,
                  ),
                ),

                // Offset
                SizedBox(height: 30),

                // Audio Button
                GestureDetector(
                  onTap: () => _speakWord(widget.word),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: kOrangeColor600,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.volume_up,
                        color: kOrangeColor200,
                        size: 130,
                      ),
                    ),
                  ),
                ),

                // Offset
                SizedBox(height: 30),

                // Offset
                SizedBox(height: 30),

                // Answer Text Field & Submit Button (Grouped for layout purposes)
                Column(
                  children: [
                    // Spelling Answer Text Field
                    SpellingAnswerTextField(
                        controller: _spellingAnswerController),

                    // Submit Button
                    RoundedRectangleButton(
                      onPressed: () async {
                        if (!_isAnswered) {
                          String answer = _spellingAnswerController.text.toLowerCase();
                          _playAnswerSound(answer);
                          setState(() {
                            _isAnswered = true;
                            bool isCorrect = (answer == widget.word);
                            result = isCorrect ? 'Correct' : 'Wrong';
                            buttonColor = isCorrect ? Colors.green : Colors.red;
                          });
                          await Future.delayed(Duration(seconds: 2));
                          _resetQuestion();
                          widget.onAnswer(answer);
                        }
                      },
                      backgroundColor: buttonColor,
                      child: Center(
                        child: Text(_isAnswered ? result! : 'Submit', style: kButtonTextStyle),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}