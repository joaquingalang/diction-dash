import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';

// TODO: Replace LinearProgressIndicator with LinearPercentIndicator from pub.dev
// TODO: LinearPercentIndicator (https://pub.dev/packages/percent_indicator)

class UserLevelBar extends StatelessWidget {
  const UserLevelBar({
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
        // Background Container
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white, // Background color for the container
            borderRadius: BorderRadius.circular(30), // Rounded corners
            border: Border.all(
              color: Colors.white, // Border color
              width: 1, // Border width
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30), // Match the rounded corners
            child: LinearProgressIndicator(
              value: currentExp / maxExp,
              backgroundColor: kGrayColor200,
              valueColor: AlwaysStoppedAnimation<Color>(kOrangeColor500),
              minHeight: 30,
            ),
          ),
        ),

        Center(
          child: Text('Level $level', style: kSubtext20),
        ),
      ],
    );
  }
}