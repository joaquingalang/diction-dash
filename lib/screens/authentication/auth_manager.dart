import 'package:flutter/material.dart';
import 'package:diction_dash/models/user_model.dart';
import 'package:diction_dash/models/minigame_stats.dart';
import 'package:diction_dash/services/auth_service.dart';
import 'package:diction_dash/services/firestore_service.dart';
import 'package:diction_dash/screens/authentication/landing_screen.dart';
import 'package:diction_dash/screens/home_screen.dart';
import 'package:provider/provider.dart';

// TODO: Since AuthManager returns the landing screen and not the registration or login screen, once a user logs in it does not automatically navigate to home screen
// TODO: ^ Temporary fix is to navigate back to AuthManager after sign up or sign in
// TODO: ^ Look into more feasible solutions

class AuthManager extends StatefulWidget {
  const AuthManager({super.key});

  @override
  State<AuthManager> createState() => _AuthManagerState();
}

class _AuthManagerState extends State<AuthManager> {
  // Firebase Authentication Instance
  final AuthService _auth = AuthService();

  // Cloud Firestore Instance
  final FirestoreService _firestore = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authListener,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String userID = _auth.currentUserID;

          // TODO: Implement StatModel StreamProvider for each Stat (Make inherited stats)
          return MultiProvider(
            providers: [
              StreamProvider<UserModel>(
                create: (context) => _firestore.getUserData(userID: userID),
                initialData:
                    UserModel(username: 'Loading...', email: 'Loading...'),
              ),
              StreamProvider<SpellingStats>(
                create: (context) => _firestore.getSpellingData(userID: userID),
                initialData:
                SpellingStats(),
              ),
              StreamProvider<VocabularyStats>(
                create: (context) => _firestore.getVocabularyData(userID: userID),
                initialData:
                VocabularyStats(),
              ),
              StreamProvider<GrammarStats>(
                create: (context) => _firestore.getGrammarData(userID: userID),
                initialData:
                GrammarStats(),
              ),
              StreamProvider<ComprehensionStats>(
                create: (context) => _firestore.getComprehensionData(userID: userID),
                initialData:
                ComprehensionStats(),
              ),
            ],
            child: HomeScreen(),
          );

        } else {
          return LandingScreen();
        }
      },
    );
  }
}
