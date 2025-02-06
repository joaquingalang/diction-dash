import 'package:flutter/material.dart';
import 'package:diction_dash/screens/authentication/landing_screen.dart';
import 'package:diction_dash/screens/authentication/login_screen.dart';
import 'package:diction_dash/screens/authentication/register_screen.dart';
import 'package:diction_dash/screens/fluency/fluency_screen.dart';
import 'package:diction_dash/screens/fluency/feedback_screen.dart';
import 'package:diction_dash/screens/home_screen.dart';
import 'package:diction_dash/screens/test_screen.dart';
import 'package:diction_dash/screens/minigame/spelling_screen.dart';
import 'package:diction_dash/screens/minigame/vocabulary_screen.dart';
import 'package:diction_dash/screens/minigame/grammar_screen.dart';
import 'package:diction_dash/screens/minigame/comprehension_screen.dart';


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
      home: SpellingScreen(),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
