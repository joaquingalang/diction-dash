import 'package:flutter/material.dart';
import 'package:diction_dash/screens/landing_screen.dart';

void main() {
  runApp(
    const DictionDash(),
  );
}

class DictionDash extends StatelessWidget {
  const DictionDash({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
