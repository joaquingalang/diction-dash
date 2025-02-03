import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
    return LinearPercentIndicator(
      width: MediaQuery.of(context).size.width,
      lineHeight: 30.0,
      animation: true,
      animationDuration: 1000,
      percent: currentExp / maxExp,
      center: Text('Level $level', style: kSubtext20),
      barRadius: Radius.circular(90),
      progressColor: kOrangeColor500,
      backgroundColor: kOrangeColor100,
    );
  }
}