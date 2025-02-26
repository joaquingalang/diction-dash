import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/screens/minigame/end_game_screen.dart';
import 'package:diction_dash/screens/minigame/comprehension/comprehension_question.dart';
import 'package:diction_dash/widgets/bottom_sheets/minigame_instruction_sheet.dart';
import 'package:diction_dash/widgets/progress_bars/question_bar.dart';

class ComprehensionScreen extends StatelessWidget {
  const ComprehensionScreen({super.key});

  void _displayInstructions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => MinigameInstructionSheet(
        title: 'Comprehension',
        description: 'Analyze the sentence carefully, and select the most appropriate answer.',
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
      body: ComprehensionQuestion(
        paragraph: 'The cat jumped onto the windowsill and watched the birds outside.',
        question: 'What did the cat do?',
        choices: ['enjoyed the view', 'leaped from a window', 'hissed at the dog', 'watched the birds outside'],
        answer: 'watched the birds outside',
        onAnswer: () => _endGameScreen(context),
      ),
    );
  }
}
