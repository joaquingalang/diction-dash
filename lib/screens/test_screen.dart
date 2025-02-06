import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:diction_dash/widgets/progress_bars/countdown_bar.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool _timerComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 30,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountdownBar(
                isStopped: _timerComplete,
                onTimerComplete: () {
                  print('CountdownBar Time Complete!');
                },
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _timerComplete = !_timerComplete;
                  });
                },
                child: Text('Stop Timer!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
