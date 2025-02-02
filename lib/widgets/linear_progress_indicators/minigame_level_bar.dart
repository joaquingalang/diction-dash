import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';

// TODO: Replace LinearProgressIndicator with LinearPercentIndicator from pub.dev
// TODO: LinearPercentIndicator (https://pub.dev/packages/percent_indicator)

class MinigameLevelBar extends StatelessWidget {
  const MinigameLevelBar({
    super.key,
    required this.level,
    required this.currentExp,
    required this.maxExp,
  });

  final int level;
  final int currentExp;
  final int maxExp;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20), // Clip for rounded corners
          child: LinearProgressIndicator(
            value: currentExp / maxExp,
            backgroundColor: kGrayColor100, // Make background transparent
            valueColor: const AlwaysStoppedAnimation<Color>(kOrangeColor300),
            minHeight: 20,
          ),
        ),
        Center(
          child: Text(
            'Level $level', // Text inside the progress bar
            style: const TextStyle(color: Colors.black), // Adjust text color
          ),
        ),
      ],
    );
  }
}