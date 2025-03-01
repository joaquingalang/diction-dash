import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:confetti/confetti.dart';
import 'package:diction_dash/services/game_audio.dart';
import 'package:diction_dash/screens/authentication/auth_manager.dart';
import 'package:diction_dash/widgets/progress_bars/question_bar.dart';
import 'package:diction_dash/widgets/progress_bars/score_bar.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';

// TODO: Add success or fail audio clips

class EndGameScreen extends StatefulWidget {
  const EndGameScreen({
    super.key,
    required this.score,
    required this.maxScore,
    this.bonusPoints = 0,
  });

  final int score;
  final int maxScore;
  final int bonusPoints;

  @override
  State<EndGameScreen> createState() => _EndGameScreenState();
}

class _EndGameScreenState extends State<EndGameScreen> {
  // Game Audio
  final GameAudio _gameAudio = GameAudio();

  // Confetti Controller
  final ConfettiController _confettiController = ConfettiController();

  // Performance & Star Colors
  String performance = 'GOOD EFFORT!';
  List<Color> starColors = [Colors.grey, Colors.grey, Colors.grey];

  void _playConfetti() async {
    if (widget.score >= 5) {
      // Play Confetti
      _confettiController.play();

      // 10 second delay to ensure that the animation played (for low-performance devices)
      await Future.delayed(Duration(seconds: 10));

      // Stop confetti controller
      _confettiController.stop();
    }
  }

  Future<void> _playJingle() async {
    if (widget.score > 0) {
      _gameAudio.congratulations();
    } else {
      _gameAudio.flop();
    }
  }

  void _setPerformance() {
    if (widget.score == 0) {
      performance = 'TRY AGAIN!';
    } else if (widget.score <= 4) {
      performance = 'GOOD EFFORT!';
    } else if (widget.score <= 8) {
      performance = 'WELL DONE!';
    } else {
      performance = 'EXCELLENT!';
    }
  }

  void _setStarColors() {
    // Set star colors based on score
    if (widget.score == 0) {
      starColors = [Colors.grey, Colors.grey, Colors.grey];
    } else if (widget.score <= 4) {
      starColors = [Colors.yellow, Colors.grey, Colors.grey];
    } else if (widget.score <= 8) {
      starColors = [Colors.yellow, Colors.yellow, Colors.grey];
    } else {
      starColors = [Colors.yellow, Colors.yellow, Colors.yellow];
    }
  }

  @override
  void initState() {
    super.initState();
    _setPerformance();
    _playJingle();
    _setStarColors();
    _playConfetti();
  }

  @override
  Widget build(BuildContext context) {
    // Stack widget is employed for playing the confetti animation over the scaffold
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // End Game Screen Scaffold
        Scaffold(
          // Minigame App Bar
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: kGrayColor500,
                size: 35,
              ),
            ),
            title: QuestionBar(currentItem: 10, maxItems: 10),
            actions: [
              IconButton(
                onPressed: () {
                  // TODO: Display Minigame Instructions
                },
                icon: Icon(
                  Icons.help,
                  color: kGrayColor500,
                  size: 35,
                ),
              ),

              // Offset
              SizedBox(width: 8),
            ],
          ),

          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Offset
                SizedBox(height: 30),

                // Performance Evaluation
                Text(performance, style: kOswaldXLarge),

                // Performance & Rewards
                Column(
                  children: [
                    // Score
                    Text('SCORE', style: kOswaldMedium),
                    ScoreBar(score: widget.score, maxScore: widget.maxScore),

                    // Offset
                    SizedBox(height: 20),

                    // Experience Points
                    Text('EXPERIENCE POINTS', style: kOswaldMedium),
                    Text(
                      '+ ${(widget.score * 10) + widget.bonusPoints} XP',
                      style: kOrangeButtonTextStyle.copyWith(fontSize: 36),
                    ),
                  ],
                ),

                // 3-Star Performance Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, size: 120, color: starColors![0]),
                    Icon(Icons.star, size: 120, color: starColors![1]),
                    Icon(Icons.star, size: 120, color: starColors![2]),
                  ],
                ),

                // Continue Button
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: RoundedRectangleButton(
                    onPressed:
                        () => // Return To AuthManager Without Route History
                            Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => AuthManager(),
                      ),
                      (Route<dynamic> route) => false,
                    ),
                    child: Center(
                      child: Text('Continue', style: kButtonTextStyle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Two Confetti Bursts

        // Faster Burst
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 50,
          emissionFrequency: 0,
          gravity: 0.5,
        ),

        // Slower Burst
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 50,
          emissionFrequency: 0,
          gravity: 0.3,
        ),
      ],
    );
  }
}
