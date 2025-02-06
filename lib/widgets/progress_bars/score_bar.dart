import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ScoreBar extends StatelessWidget {
  const ScoreBar({super.key, required this.score, required this.maxScore});

  final int score;
  final int maxScore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: MediaQuery.sizeOf(context).width * 0.2),
        LinearPercentIndicator(
          width: MediaQuery.sizeOf(context).width * 0.6,
          lineHeight: 30,
          progressColor: kOrangeColor600,
          barRadius: Radius.circular(90),
          percent: score / maxScore,
          center: Text(
            '$score / $maxScore',
            style: kSubtext20.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}