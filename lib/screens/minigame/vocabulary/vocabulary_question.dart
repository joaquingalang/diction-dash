import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/services/game_audio.dart';
import 'package:diction_dash/services/settings_service.dart';
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
  final Function(String, int) onAnswer;

  @override
  State<VocabularyQuestion> createState() => _VocabularyQuestionState();
}

class _VocabularyQuestionState extends State<VocabularyQuestion> {
  // Settings Instance
  final SettingsService _settings = SettingsService();

  // Settings
  bool _isLoading = true;
  bool _gameAudioEnabled = true;
  bool _capslockEnabled = false;

  // Game Audio
  final GameAudio _gameAudio = GameAudio();

  // Question State Data
  bool _isAnswered = false;
  DateTime _startTime = DateTime.now();
  DateTime? _endTime;
  List<Color> buttonColors = [
    kOrangeColor600,
    kOrangeColor600,
    kOrangeColor600,
    kOrangeColor600
  ];

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

  // Resets Question Properties
  void _resetQuestion() {
    setState(() {
      _isAnswered = false;
      _startTime = DateTime.now();
      _endTime = null;
      buttonColors = [
        kOrangeColor600,
        kOrangeColor600,
        kOrangeColor600,
        kOrangeColor600
      ];
    });
  }

  // Calculates Time Bonus Points
  int _calculateBonusPoints() {
    Duration finalTime = _endTime!.difference(_startTime);
    int bonusPoints = ((15 - finalTime.inSeconds) / 3).toInt();
    // +1 point buffer for loading
    bonusPoints = bonusPoints + 1;
    // Bonus points should still max out at 5
    bonusPoints = (bonusPoints > 5) ? 5 : bonusPoints;
    return bonusPoints;
  }

  Future<void> _selectChoice(int choiceIndex) async {
    if (!_isAnswered) {
      setState(() {
        _isAnswered = true;
        _endTime = DateTime.now();
        buttonColors[choiceIndex] =
            (widget.answer == widget.choices[choiceIndex])
                ? Colors.green
                : Colors.red;
        buttonColors[widget.choices.indexOf(widget.answer)] = Colors.green;
      });
      int bonusPoints = _calculateBonusPoints();
      if (_gameAudioEnabled) {
        _playAnswerSound(widget.choices[choiceIndex]);
      }
      await Future.delayed(Duration(seconds: 2));
      _resetQuestion();
      widget.onAnswer(widget.choices[choiceIndex], bonusPoints);
    }
  }

  @override
  void initState() {
    super.initState();
    _initSettings();
  }

  @override
  Widget build(BuildContext context) {
    return (!_isLoading)
        ? PopScope(
            canPop: true,
            onPopInvokedWithResult: (didPop, result) {
              // On page exit, mark question answered to dispose countdown timer
              if (didPop) {
                setState(() {
                  _isAnswered = true;
                });
              }
            },
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Countdown Bar
                  CountdownBar(
                    isStopped: _isAnswered,
                    onTimerComplete: _questionTimeout,
                  ),

                  // Vocabulary Minigame Instructions
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: kSubtext20,
                      children: [
                        TextSpan(
                          text: (!_capslockEnabled)
                              ? 'Select the appropriate'
                              : 'Select the appropriate'.toUpperCase(),
                        ),
                        TextSpan(
                          text: (!_capslockEnabled)
                              ? '\nsynonym.'
                              : '\nsynonym.'.toUpperCase(),
                          style: kFontWeightBold,
                        ),
                      ],
                    ),
                  ),

                  // Offset
                  SizedBox(height: 30),

                  // Provided Word
                  Text(
                    (!_capslockEnabled)
                        ? widget.word
                        : widget.word.toUpperCase(),
                    style: kOswaldLarge,
                    textAlign: TextAlign.center,
                  ),

                  // Offset
                  SizedBox(height: 30),

                  // Choices
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        OvalButton(
                          onPressed: () => _selectChoice(0),
                          color: buttonColors[0],
                          child: Center(
                            child: Text(
                              (!_capslockEnabled)
                                  ? widget.choices[0]
                                  : widget.choices[0].toString().toUpperCase(),
                              style: kButtonTextStyle,
                            ),
                          ),
                        ),
                        OvalButton(
                          onPressed: () => _selectChoice(1),
                          color: buttonColors[1],
                          child: Center(
                            child: Text(
                              (!_capslockEnabled)
                                  ? widget.choices[1]
                                  : widget.choices[1].toString().toUpperCase(),
                              style: kButtonTextStyle,
                            ),
                          ),
                        ),
                        OvalButton(
                          onPressed: () => _selectChoice(2),
                          color: buttonColors[2],
                          child: Center(
                            child: Text(
                              (!_capslockEnabled)
                                  ? widget.choices[2]
                                  : widget.choices[2].toString().toUpperCase(),
                              style: kButtonTextStyle,
                            ),
                          ),
                        ),
                        OvalButton(
                          onPressed: () => _selectChoice(3),
                          color: buttonColors[3],
                          child: Center(
                            child: Text(
                              (!_capslockEnabled)
                                  ? widget.choices[3]
                                  : widget.choices[3].toString().toUpperCase(),
                              style: kButtonTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : CircularProgressIndicator(color: kOrangeColor300);
  }
}
