import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';

// TODO: Fix bug where the audio still plays even after minigame is cancelled because the timer is still active

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
    with SingleTickerProviderStateMixin {
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
        tween: ColorTween(begin: Colors.red, end: Colors.yellow),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 50,
      ),
    ]).animate(_controller);

    // Add a listener to trigger the callback once the timer finishes
    _controller.addStatusListener(
      (status) {
        print(_colorAnimation);
        if (status.isDismissed) {
          widget.onTimerComplete();
        }
      },
    );
  }

  void _startTimer() {
    // Starts countdown when called (1 represents the animation value not the duration in seconds)
    _controller.reverse(from: 1);
  }

  void _resetTimer() {
    _controller.reset();
  }

  @override
  void initState() {
    super.initState();
    _initAnimationController();
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant CountdownBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isStopped) {
      _controller.stop();
      _resetTimer();
    } else {
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return LinearProgressIndicator(
          value: _controller.value,
          valueColor: _colorAnimation,
          backgroundColor: kGrayColor300,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}