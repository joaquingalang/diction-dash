import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/progress_bars/question_bar.dart';
import 'package:diction_dash/widgets/progress_bars/score_bar.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';

// TODO: Add confetti animations
// TODO: Add success or fail audio clips

class EndGameScreen extends StatefulWidget {
  const EndGameScreen({super.key});

  @override
  State<EndGameScreen> createState() => _EndGameScreenState();
}

class _EndGameScreenState extends State<EndGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Minigame App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
        centerTitle: true,
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
    );
  }
}
