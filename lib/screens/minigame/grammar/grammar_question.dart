import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/services/game_audio.dart';
import 'package:diction_dash/services/settings_service.dart';
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
  final Function(bool, int) onAnswer;

  @override
  State<GrammarQuestion> createState() => _GrammarQuestionState();
}

class _GrammarQuestionState extends State<GrammarQuestion> {
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
  List<Color> _buttonColors = [kOrangeColor600, Colors.white];
  TextStyle _incorrectButtonTextStyle = kOrangeButtonTextStyle;

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
  void _playAnswerSound(bool answer) {
    if (answer == widget.isCorrect) {
      _gameAudio.correctAnswer();
    } else {
      _gameAudio.incorrectAnswer();
    }
  }

  // Resets Question Properties
  void _resetQuestion() {
    setState(() {
      _isAnswered = false;
      _startTime = DateTime.now();
      _endTime = null;
      _buttonColors = [kOrangeColor600, Colors.white];
      _incorrectButtonTextStyle = kOrangeButtonTextStyle;
    });
  }

  // Marks Question As Incorrect After Countdown
  void _questionTimeout() async {
    if (!_isAnswered) {
      if (widget.isCorrect) {
        setState(() {
          _isAnswered = true;
          _buttonColors[0] = Colors.red;
        });
      } else {
        setState(() {
          _isAnswered = true;
          _buttonColors[1] = Colors.red;
          _incorrectButtonTextStyle = kButtonTextStyle;
        });
      }
      if (_gameAudioEnabled) {
        _gameAudio.incorrectAnswer();
      }
      await Future.delayed(Duration(seconds: 2));
      _resetQuestion();
      bool wrongAnswer = !widget.isCorrect;
      int bonusPoints = 0;
      widget.onAnswer(wrongAnswer, bonusPoints);
    }
  }

  // Calculates Time Bonus Points
  int calculateBonusPoints() {
    Duration finalTime = _endTime!.difference(_startTime);
    int bonusPoints = ((15 - finalTime.inSeconds) / 3).toInt();
    // +1 point buffer for loading
    bonusPoints = bonusPoints + 1;
    // Bonus points should still max out at 5
    bonusPoints = (bonusPoints > 5) ? 5 : bonusPoints;
    return bonusPoints;
  }

  void _selectChoice(bool answer) async {
    if (!_isAnswered) {
      int choiceIndex = answer ? 0 : 1;
      setState(() {
        _isAnswered = true;
        _endTime = DateTime.now();
        _buttonColors[choiceIndex] =
            (answer == widget.isCorrect) ? Colors.green : Colors.red;
        if (choiceIndex == 1) {
          _incorrectButtonTextStyle = kButtonTextStyle;
        }
      });
      int bonusPoints = calculateBonusPoints();
      if (_gameAudioEnabled) {
        _playAnswerSound(answer);
      }
      await Future.delayed(Duration(seconds: 2));
      _resetQuestion();
      widget.onAnswer(answer, bonusPoints);
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

                  // Grammar Minigame Instructions
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: kSubtext20,
                      children: [
                        TextSpan(
                          text: (!_capslockEnabled)
                              ? 'Identify if the sentence\nis '
                              : 'Identify if the sentence\nis '.toUpperCase(),
                        ),
                        TextSpan(
                          text: (!_capslockEnabled)
                              ? 'grammatically correct.'
                              : 'grammatically correct.'.toUpperCase(),
                          style: kFontWeightBold,
                        ),
                      ],
                    ),
                  ),

                  // Offset
                  SizedBox(height: 30),

                  // Grammar Question
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      (!_capslockEnabled)
                          ? widget.phrase
                          : widget.phrase.toUpperCase(),
                      style: kSubtext20,
                      textAlign: TextAlign.center,
                    ),
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
                          onPressed: () => _selectChoice(true),
                          color: _buttonColors[0],
                          child: Center(
                            child: Text('CORRECT', style: kButtonTextStyle),
                          ),
                        ),
                        OvalButton(
                          color: _buttonColors[1],
                          borderColor: (_buttonColors[1] == Colors.white)
                              ? kOrangeColor600
                              : null,
                          onPressed: () => _selectChoice(false),
                          child: Center(
                            child: Text('INCORRECT',
                                style: _incorrectButtonTextStyle),
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
