import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/progress_bars/user_level_bar.dart';
import 'package:diction_dash/widgets/cards/stat_card.dart';
import 'package:diction_dash/screens/settings/settings_screen.dart';
import 'package:diction_dash/screens/minigame/spelling_screen.dart';
import 'package:diction_dash/screens/minigame/vocabulary_screen.dart';
import 'package:diction_dash/screens/minigame/grammar_screen.dart';
import 'package:diction_dash/screens/minigame/comprehension_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Widget Dimensions For Responsiveness
    double screenHeight = MediaQuery.sizeOf(context).height;
    double cardHeight = (screenHeight / 6.7).toInt() * 5;
    double profilePictureOffset = cardHeight - 75;

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
                    'USERNAME',
                    textAlign: TextAlign.center,
                    style: kOswaldLarge,
                  ),

                  // User Level Bar
                  UserLevelBar(level: 6, currentExp: 200, maxExp: 600),

                  // Offset
                  SizedBox(height: 10),

                  // Stat Cards
                  StatCard(
                    text: 'SPELLING',
                    image: AssetImage('assets/images/app_icon.png'),
                    level: 1,
                    currentExp: 20,
                    maxExp: 100,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpellingScreen(),
                      ),
                    ),
                  ),
                  StatCard(
                    text: 'VOCABULARY',
                    image: AssetImage('assets/images/app_icon.png'),
                    level: 1,
                    currentExp: 20,
                    maxExp: 100,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VocabularyScreen(),
                      ),
                    ),
                  ),
                  StatCard(
                    text: 'GRAMMAR',
                    image: AssetImage('assets/images/app_icon.png'),
                    level: 1,
                    currentExp: 20,
                    maxExp: 100,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GrammarScreen(),
                      ),
                    ),
                  ),
                  StatCard(
                    text: 'COMPREHENSION',
                    image: AssetImage('assets/images/app_icon.png'),
                    level: 1,
                    currentExp: 20,
                    maxExp: 100,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComprehensionScreen(),
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
