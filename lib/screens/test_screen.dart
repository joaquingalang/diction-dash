import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 20,
            lineHeight: 30.0,
            animation: true,
            animationDuration: 2500,
            percent: 0.8,
            center: Text("80.0%"),
            barRadius: Radius.circular(90),
            progressColor: Colors.green,
          ),
        ),
      ),
    );
  }
}
