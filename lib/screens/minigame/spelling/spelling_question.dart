import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/screens/minigame/end_game_screen.dart';
import 'package:diction_dash/widgets/progress_bars/countdown_bar.dart';
import 'package:diction_dash/widgets/text_fields/spelling_answer_text_field.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';

class SpellingQuestion extends StatefulWidget {
  const SpellingQuestion({
    super.key,
    required this.word,
    required this.definition,
  });

  final String word;
  final String definition;

  @override
  State<SpellingQuestion> createState() => _SpellingQuestionState();
}

class _SpellingQuestionState extends State<SpellingQuestion> {

  final TextEditingController _spellingAnswerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
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
                          text: ('_ ' * widget.word.length).trim(),
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
                    widget.definition,
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
    );
  }
}