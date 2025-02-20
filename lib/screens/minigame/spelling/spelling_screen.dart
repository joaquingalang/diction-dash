import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/screens/minigame/end_game_screen.dart';
import 'package:diction_dash/screens/minigame/spelling/spelling_question.dart';
import 'package:diction_dash/widgets/bottom_sheets/minigame_instruction_sheet.dart';
import 'package:diction_dash/widgets/progress_bars/question_bar.dart';

// TODO: Separate SpellingScreen with SpellingQuestion

class SpellingScreen extends StatelessWidget {
  const SpellingScreen({super.key});

  void _displayInstructions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => MinigameInstructionSheet(
        title: 'Spelling',
        description:
            'Listen to the audio carefully and make sure to type the word in the answer box.',
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
        scrolledUnderElevation: 0,
      ),

      // Page BodyW
      body: SpellingQuestion(
        word: 'charisma',
        definition: 'compelling attractiveness or charm that can inspire devotion in others.',
        onAnswer: () => _endGameScreen(context),
      ),
    );
  }
}
