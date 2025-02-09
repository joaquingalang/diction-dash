import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
    return LinearPercentIndicator(
      width: MediaQuery.of(context).size.width * 0.746,
      lineHeight: 20,
      animation: true,
      animationDuration: 1000,
      percent: currentExp / maxExp,
      center: Text('Level $level', style: kSubtext15),
      barRadius: Radius.circular(90),
      progressColor: kOrangeColor300,
      backgroundColor: kOrangeColor100,
    );
  }
}