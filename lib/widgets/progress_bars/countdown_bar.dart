import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';

class CountdownBar extends StatefulWidget {
  const CountdownBar({
    super.key,
    this.durationInSeconds = 15, // 15 seconds by default
    required this.isStopped,
    required this.onTimerComplete,
  });

  final int durationInSeconds;
  final bool isStopped;
  final VoidCallback onTimerComplete;

  @override
  State<CountdownBar> createState() => _CountdownBarState();
}

class _CountdownBarState extends State<CountdownBar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  void _initAnimationController() {
    // Initialize animation controller without starting it automatically
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationInSeconds),
    );

    // Define countdown's color tween animation (Green -> Orange -> Red)
    _colorAnimation = TweenSequence<Color?>([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.orange.shade100),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.orange.shade100, end: Colors.green),
        weight: 50,
      ),
    ]).animate(_controller);

    // Add a listener to trigger the callback once the timer finishes
    _controller.addStatusListener(
      (status) {
        if (status.isDismissed) {
          widget.onTimerComplete();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
