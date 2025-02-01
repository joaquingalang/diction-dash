import 'package:flutter/material.dart';
import 'package:diction_dash/screens/landing_screen.dart';
import 'package:diction_dash/screens/login_screen.dart';
import 'package:diction_dash/screens/register_screen.dart';

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
      home: RegisterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
