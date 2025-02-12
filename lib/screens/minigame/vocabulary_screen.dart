import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/screens/minigame/end_game_screen.dart';
import 'package:diction_dash/widgets/bottom_sheets/minigame_instruction_sheet.dart';
import 'package:diction_dash/widgets/progress_bars/question_bar.dart';
import 'package:diction_dash/widgets/progress_bars/countdown_bar.dart';
import 'package:diction_dash/widgets/buttons/oval_button.dart';

// TODO: Separate Screen with Question

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key});

  void _displayInstructions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => MinigameInstructionSheet(
        title: 'Vocabulary',
        description: 'Select the choice that has the same meaning as the provided word.',
      ),
    );
  }

  void _endGameScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EndGameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Minigame App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            color: kGrayColor500,
            size: 35,
          ),
        ),
        title: QuestionBar(currentItem: 1, maxItems: 10),
        actions: [
          IconButton(
            onPressed: () => _displayInstructions(context),
            icon: Icon(
              Icons.help,
              color: kGrayColor500,
              size: 35,
            ),
          ),

          // Offset
          SizedBox(width: 8),
        ],
      ),

      // Page Body
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // Countdown Bar
            CountdownBar(
              isStopped: false,
              onTimerComplete: () {
                print('Timer Complete!');
              },
            ),

            // Vocabulary Minigame Instructions
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: kSubtext20,
                children: [
                  TextSpan(
                    text: 'Select the appropriate',
                  ),
                  TextSpan(
                    text: '\nsynonym.',
                    style: kFontWeightBold,
                  ),
                ],
              ),
            ),

            // Offset
            SizedBox(height: 30),

            // Provided Word
            Text(
              'distinct',
              style: kOswaldLarge,
              textAlign: TextAlign.center,
            ),

            // Offset
            SizedBox(height: 30),

            // Choices
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  OvalButton(
                    onPressed: () => _endGameScreen(context),
                    child: Center(
                      child: Text('mystic', style: kButtonTextStyle),
                    ),
                  ),
                  OvalButton(
                    onPressed: () => _endGameScreen(context),
                    child: Center(
                      child: Text('demure', style: kButtonTextStyle),
                    ),
                  ),
                  OvalButton(
                    onPressed: () => _endGameScreen(context),
                    child: Center(
                      child: Text('unique', style: kButtonTextStyle),
                    ),
                  ),
                  OvalButton(
                    onPressed: () => _endGameScreen(context),
                    child: Center(
                      child: Text('exhausted', style: kButtonTextStyle),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
