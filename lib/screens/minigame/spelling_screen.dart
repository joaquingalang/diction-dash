import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/screens/minigame/end_game_screen.dart';
import 'package:diction_dash/widgets/bottom_sheets/minigame_instruction_sheet.dart';
import 'package:diction_dash/widgets/progress_bars/question_bar.dart';
import 'package:diction_dash/widgets/progress_bars/countdown_bar.dart';
import 'package:diction_dash/widgets/text_fields/spelling_answer_text_field.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';

// TODO: Separate SpellingScreen with SpellingQuestion

class SpellingScreen extends StatefulWidget {
  const SpellingScreen({super.key});

  @override
  State<SpellingScreen> createState() => _SpellingScreenState();
}

class _SpellingScreenState extends State<SpellingScreen> {
  // Answer Text Controller
  late TextEditingController _spellingAnswerController;

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

  @override
  void initState() {
    _spellingAnswerController = TextEditingController();
    super.initState();
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
      body: Builder(
        // Builder used to get max appbar height and subtract it from screen height
        // This difference is used to set a scrollable fixed body height
        builder: (context) => SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  Scaffold.of(context).appBarMaxHeight! - 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Countdown Bar
                  CountdownBar(
                    durationInSeconds: 20,
                    isStopped: false,
                    onTimerComplete: () {
                      print('Timer Complete!');
                    },
                  ),

                  // Spelling Minigame Instructions
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: kSubtext20,
                      children: [
                        TextSpan(
                          text: 'Spell',
                          style: kFontWeightBold,
                        ),
                        TextSpan(
                          text: ' the following word:\n',
                        ),
                        TextSpan(
                            text: '_ _ _ _ _ _ _ _',
                            style: kHiddenWordTextStyle),
                      ],
                    ),
                  ),

                  // Offset
                  SizedBox(height: 30),

                  // Definition Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'compelling attractiveness or charm that can inspire devotion in others.',
                      style: kSubtext20,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Offset
                  SizedBox(height: 30),

                  // Audio Button
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: kOrangeColor600,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.volume_up,
                          color: kOrangeColor200,
                          size: 130,
                        ),
                      ),
                    ),
                  ),

                  // Offset
                  SizedBox(height: 30),

                  // Offset
                  SizedBox(height: 30),

                  // Answer Text Field & Submit Button (Grouped for layout purposes)
                  Column(
                    children: [
                      // Spelling Answer Text Field
                      SpellingAnswerTextField(
                          controller: _spellingAnswerController),

                      // Submit Button
                      RoundedRectangleButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EndGameScreen(),
                          ),
                        ),
                        child: Center(
                          child: Text('Submit', style: kButtonTextStyle),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
