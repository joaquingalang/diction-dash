import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:diction_dash/firebase_options.dart';
import 'package:diction_dash/screens/authentication/auth_manager.dart';
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
import 'package:diction_dash/screens/minigame/end_game_screen.dart';
import 'package:diction_dash/screens/settings/settings_screen.dart';
import 'package:diction_dash/screens/settings/profile_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const DictionDash(),
  );
}

class DictionDash extends StatelessWidget {
  const DictionDash({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      home: AuthManager(),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
