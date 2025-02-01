import 'package:flutter/material.dart';
import 'package:diction_dash/screens/landing_screen.dart';
import 'package:diction_dash/screens/login_screen.dart';
import 'package:diction_dash/screens/register_screen.dart';
import 'package:diction_dash/screens/fluency_screen.dart';
import 'package:diction_dash/screens/feedback_screen.dart';

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
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
