import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/progress_bars/question_bar.dart';
import 'package:diction_dash/widgets/text_fields/spelling_answer_text_field.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';

// TODO: Separate SpellingScreen with SpellingQuestionBody

class SpellingScreen extends StatefulWidget {
  const SpellingScreen({super.key});

  @override
  State<SpellingScreen> createState() => _SpellingScreenState();
}

class _SpellingScreenState extends State<SpellingScreen> {
  late TextEditingController _spellingAnswerController;

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
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
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
                      text: '_ _ _ _ _ _ _ _', style: kHiddenWordTextStyle),
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
                SpellingAnswerTextField(controller: _spellingAnswerController),

                // Submit Button
                RoundedRectangleButton(
                  onPressed: () {},
                  child: Center(
                    child: Text('Submit', style: kButtonTextStyle),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
