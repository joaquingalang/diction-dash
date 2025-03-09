import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:diction_dash/services/game_audio.dart';
import 'package:diction_dash/services/settings_service.dart';
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
  final Function(String, int) onAnswer;

  @override
  State<SpellingQuestion> createState() => _SpellingQuestionState();
}

class _SpellingQuestionState extends State<SpellingQuestion> {
  // Settings Instance
  final SettingsService _settings = SettingsService();

  // Settings
  bool _isLoading = true;
  bool _gameAudioEnabled = true;
  bool _capslockEnabled = false;

  // Spelling Answer Text Editing Controller
  final TextEditingController _spellingAnswerController =
      TextEditingController();

  // Text To Speech
  final FlutterTts _flutterTts = FlutterTts();

  // Game Audio
  final GameAudio _gameAudio = GameAudio();

  // Question State Data
  bool _isAnswered = false;
  DateTime _startTime = DateTime.now();
  DateTime? _endTime;
  String? result;
  Color buttonColor = kOrangeColor600;

  void _initSettings() async {
    // Get Game Audio Setting
    bool gameAudio = await _settings.getGameAudio();

    // Get Capslock Setting
    bool capslock = await _settings.getCapslock();

    setState(() {
      _gameAudioEnabled = gameAudio;
      _capslockEnabled = capslock;
      _isLoading = false;
    });
  }

  Future<void> _initFlutterTts() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setPitch(1);
    await _flutterTts.setSpeechRate(0.5);
  }

  Future<void> _speakWord(String word) async {
    if (word.isNotEmpty) {
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
      _startTime = DateTime.now();
      _endTime = null;
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
        result = (!_capslockEnabled) ? 'Wrong' : 'Wrong'.toUpperCase();
      });
      if (_gameAudioEnabled) {
        _gameAudio.incorrectAnswer();
      }
      await Future.delayed(Duration(seconds: 2));
      _resetQuestion();
      String wrongAnswer = '';
      int bonusPoints = 0;
      widget.onAnswer(wrongAnswer, bonusPoints);
    }
  }

  // Calculates Time Bonus Points
  int calculateBonusPoints() {
    Duration finalTime = _endTime!.difference(_startTime);
    int bonusPoints = ((20 - finalTime.inSeconds) / 4).toInt();
    // +1 point buffer for loading
    bonusPoints = bonusPoints + 1;
    // Bonus points should still max out at 5
    bonusPoints = (bonusPoints > 5) ? 5 : bonusPoints;
    return bonusPoints;
  }

  @override
  void initState() {
    super.initState();
    _initSettings();
    _initFlutterTts();
  }

  @override
  Widget build(BuildContext context) {
    return (!_isLoading)
        ? Builder(
            // Builder used to get max appbar height and subtract it from screen height
            // This difference is used to set a scrollable fixed body height
            builder: (context) => SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height -
                      Scaffold.of(context).appBarMaxHeight! -
                      20,
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
                              text: (!_capslockEnabled)
                                  ? 'Spell'
                                  : 'Spell'.toUpperCase(),
                              style: kFontWeightBold,
                            ),
                            TextSpan(
                              text: (!_capslockEnabled)
                                  ? ' the following word:\n'
                                  : ' the following word:\n'.toUpperCase(),
                            ),
                            TextSpan(
                                text: (_isAnswered)
                                    ? (!_capslockEnabled)
                                        ? widget.word
                                        : widget.word.toUpperCase()
                                    : ('_ ' * widget.word.length).trim(),
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
                          (!_capslockEnabled)
                              ? widget.definition
                              : widget.definition.toUpperCase(),
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
                                String answer = _spellingAnswerController.text
                                    .toLowerCase();
                                setState(() {
                                  _isAnswered = true;
                                  _endTime = DateTime.now();
                                  bool isCorrect = (answer == widget.word);
                                  result = isCorrect
                                      ? (!_capslockEnabled)
                                          ? 'Correct'
                                          : 'Correct'.toUpperCase()
                                      : (!_capslockEnabled)
                                          ? 'Wrong'
                                          : 'Wrong'.toUpperCase();
                                  buttonColor =
                                      isCorrect ? Colors.green : Colors.red;
                                });
                                int bonusPoints = calculateBonusPoints();
                                if (_gameAudioEnabled) {
                                  _playAnswerSound(answer);
                                }
                                await Future.delayed(Duration(seconds: 2));
                                _resetQuestion();
                                widget.onAnswer(answer, bonusPoints);
                              }
                            },
                            backgroundColor: buttonColor,
                            child: Center(
                              child: Text(
                                  _isAnswered
                                      ? result!
                                      : (!_capslockEnabled)
                                          ? 'Submit'
                                          : 'Submit'.toUpperCase(),
                                  style: kButtonTextStyle),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : CircularProgressIndicator(color: kOrangeColor300);
  }
}
