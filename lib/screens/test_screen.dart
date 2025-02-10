import 'package:diction_dash/widgets/loading_indicators/fox_loading_indicator.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Foxloadingindicator(),
    );
  }
}
