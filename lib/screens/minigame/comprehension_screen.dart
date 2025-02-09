import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/bottom_sheets/minigame_instruction_sheet.dart';
import 'package:diction_dash/widgets/progress_bars/question_bar.dart';
import 'package:diction_dash/widgets/progress_bars/countdown_bar.dart';
import 'package:diction_dash/widgets/buttons/oval_button.dart';
import 'package:diction_dash/screens/minigame/end_game_screen.dart';

// TODO: Separate ComprehensionScreen with ComprehensionQuestion

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

            // Comprehension Minigame Instruction
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: kSubtext20,
                children: [
                  TextSpan(text: 'Comprehend ', style: kFontWeightBold),
                  TextSpan(
                      text: 'the sentence\nand answer the given question.'),
                ],
              ),
            ),

            // Offset
            SizedBox(height: 30),

            // Comprehension Question
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'The cat jumped onto the windowsill and watched the birds outside.\n\nWhat did the cat do?',
                style: kSubtext20,
                textAlign: TextAlign.center,
              ),
            ),

            // Offset
            SizedBox(height: 30),

            // Choices
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  OvalButton(
                    onPressed: () => _endGameScreen(context),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text('enjoyed the view', style: kButtonTextStyle),
                    ),
                  ),
                  OvalButton(
                    onPressed: () => _endGameScreen(context),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text('leaped from a window', style: kButtonTextStyle),
                    ),
                  ),
                  OvalButton(
                    onPressed: () => _endGameScreen(context),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text('hissed at the dog', style: kButtonTextStyle),
                    ),
                  ),
                  OvalButton(
                    onPressed: () => _endGameScreen(context),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text('watched the birds outside', style: kButtonTextStyle),
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
