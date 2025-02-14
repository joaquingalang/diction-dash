import 'package:flutter/material.dart';

// TODO: Try and make background white when this widget is used in the showDialogue function

class Foxloadingindicator extends StatelessWidget {
  const Foxloadingindicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Image.asset('assets/images/fox_loading.gif', width: 100),
      ),
    );
  }
}
