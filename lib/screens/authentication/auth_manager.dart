import 'package:flutter/material.dart';
import 'package:diction_dash/services/auth_service.dart';
import 'package:diction_dash/screens/authentication/landing_screen.dart';
import 'package:diction_dash/screens/home_screen.dart';

// TODO: Since AuthManager returns the landing screen and not the registration or login screen, once a user logs in it does not automatically navigate to home screen
// TODO: ^ Temporary fix is to navigate back to AuthManager after sign up or sign in
// TODO: ^ Look into more feasible solutions

class AuthManager extends StatefulWidget {
  const AuthManager({super.key});

  @override
  State<AuthManager> createState() => _AuthManagerState();
}

class _AuthManagerState extends State<AuthManager> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authListener(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();

          // TODO: If snapshot has data but the user does not have a fluency score yet, return the FluencyScreen instead.

        } else {
          return LandingScreen();
        }
      },
    );
  }
}
