import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuestionBar extends StatelessWidget {
  const QuestionBar({
    super.key,
    required this.currentItem,
    required this.maxItems,
  });

  final int currentItem;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      width: MediaQuery.of(context).size.width - 150,
      lineHeight: 30,
      progressColor: kOrangeColor600,
      backgroundColor: kOrangeColor100,
      barRadius: Radius.circular(90),
      animation: true,
      animationDuration: 500,
      animateFromLastPercent: true,
      percent: currentItem / maxItems,
      center: Text(
        '$currentItem / $maxItems',
        style: kSubtext20.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
