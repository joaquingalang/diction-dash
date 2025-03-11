import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/models/user_model.dart';
import 'package:diction_dash/models/minigame_stats.dart';
import 'package:diction_dash/services/auth_service.dart';
import 'package:diction_dash/services/firestore_service.dart';
import 'package:diction_dash/widgets/progress_bars/user_level_bar.dart';
import 'package:diction_dash/widgets/cards/stat_card.dart';
import 'package:diction_dash/screens/settings/settings_screen.dart';
import 'package:diction_dash/screens/minigame/spelling/spelling_screen.dart';
import 'package:diction_dash/screens/minigame/vocabulary/vocabulary_screen.dart';
import 'package:diction_dash/screens/minigame/grammar/grammar_screen.dart';
import 'package:diction_dash/screens/minigame/comprehension/comprehension_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Firebase Authentication Instance
  final AuthService _auth = AuthService();

  // Cloud Firestore Instance
  final FirestoreService _firestore = FirestoreService();

  @override
  Widget build(BuildContext context) {
    // Widget Dimensions For Responsiveness
    double screenHeight = MediaQuery.sizeOf(context).height;
    double cardHeight = (screenHeight / 6.7).toInt() * 5;
    double profilePictureOffset = cardHeight - 75;

    // User & Minigame Stats
    final UserModel userData = context.watch<UserModel>();
    final SpellingStats spellingStats = context.watch<SpellingStats>();
    final VocabularyStats vocabularyStats = context.watch<VocabularyStats>();
    final GrammarStats grammarStats = context.watch<GrammarStats>();
    final ComprehensionStats comprehensionStats =
        context.watch<ComprehensionStats>();

    return Scaffold(
      // Page Background Color
      backgroundColor: kOrangeColor600,

      // Page App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: SizedBox(), // TODO: temporary fix to remove back button
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsScreen(),
              ),
            ),
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),

      // Page Body
      body: Stack(
        children: [
          // Profile & Minigame Card
          Align(
            alignment: Alignment.bottomCenter,

            // Card Dimensions & Shape
            child: Container(
              width: double.infinity,
              height: cardHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),

              // Card Content
              child: Column(
                children: [
                  // Offset
                  SizedBox(height: 60),

                  // Username
                  Text(
                    userData.username ?? '',
                    textAlign: TextAlign.center,
                    style: kOswaldLarge,
                  ),

                  // User Level Bar
                  UserLevelBar(
                    level: userData.level,
                    currentExp: userData.exp,
                    maxExp: userData.maxExp,
                  ),

                  // Offset
                  SizedBox(height: 10),

                  // Stat Cards
                  StatCard(
                    text: 'SPELLING',
                    image: AssetImage('assets/images/spelling.png'),
                    level: spellingStats.level,
                    currentExp: spellingStats.exp,
                    maxExp: spellingStats.maxExp,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SpellingScreen(fluency: userData.fluency!),
                      ),
                    ),
                  ),
                  StatCard(
                    text: 'VOCABULARY',
                    image: AssetImage('assets/images/vocabulary.png'),
                    level: vocabularyStats.level,
                    currentExp: vocabularyStats.exp,
                    maxExp: vocabularyStats.maxExp,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VocabularyScreen(fluency: userData.fluency!),
                      ),
                    ),
                  ),
                  StatCard(
                    text: 'GRAMMAR',
                    image: AssetImage('assets/images/grammar.png'),
                    level: grammarStats.level,
                    currentExp: grammarStats.exp,
                    maxExp: grammarStats.maxExp,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GrammarScreen(fluency: userData.fluency!),
                      ),
                    ),
                  ),
                  StatCard(
                    text: 'COMPREHENSION',
                    image: AssetImage('assets/images/comprehension.png'),
                    level: comprehensionStats.level,
                    currentExp: comprehensionStats.exp,
                    maxExp: comprehensionStats.maxExp,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ComprehensionScreen(fluency: userData.fluency!),
                      ),
                    ),
                  ),

                  // Offset
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Profile Picture
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              // Profile Picture Offset (ex. 530px from bottom center)
              padding: EdgeInsets.only(bottom: profilePictureOffset),

              // Profile Picture
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage:
                      AssetImage('assets/images/placeholder_profile.png'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
