import 'package:flutter/material.dart';

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
