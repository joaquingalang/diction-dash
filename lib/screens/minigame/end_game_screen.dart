import 'dart:math';
import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:confetti/confetti.dart';
import 'package:diction_dash/widgets/progress_bars/question_bar.dart';
import 'package:diction_dash/widgets/progress_bars/score_bar.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';

// TODO: Add success or fail audio clips

class EndGameScreen extends StatefulWidget {
  const EndGameScreen({super.key});

  @override
  State<EndGameScreen> createState() => _EndGameScreenState();
}

class _EndGameScreenState extends State<EndGameScreen> {
  final ConfettiController _confettiController = ConfettiController();

  void _playConfetti() async {
    // Play Confetti
    _confettiController.play();

    // 10 second delay to ensure that the animation played (for low-performance devices)
    await Future.delayed(Duration(seconds: 10));

    // Stop confetti controller
    _confettiController.stop();
  }

  @override
  void initState() {
    super.initState();
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
                  Navigator.pop(context);
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
                Text('EXCELLENT!', style: kOswaldXLarge),

                // Performance & Rewards
                Column(
                  children: [
                    // Score
                    Text('SCORE', style: kOswaldMedium),
                    ScoreBar(score: 8, maxScore: 10),

                    // Offset
                    SizedBox(height: 20),

                    // Experience Points
                    Text('EXPERIENCE POINTS', style: kOswaldMedium),
                    Text(
                      '+ 1028 XP',
                      style: kButtonTextStyleOrange.copyWith(fontSize: 36),
                    ),
                  ],
                ),

                // 3-Star Performance Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, size: 120, color: Colors.yellow),
                    Icon(Icons.star, size: 120, color: Colors.yellow),
                    Icon(Icons.star, size: 120, color: Colors.grey),
                  ],
                ),

                // Continue Button
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: RoundedRectangleButton(
                    onPressed: () {},
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
