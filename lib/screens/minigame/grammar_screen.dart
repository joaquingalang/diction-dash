import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/progress_bars/question_bar.dart';
import 'package:diction_dash/widgets/buttons/oval_button.dart';

class GrammarScreen extends StatelessWidget {
  const GrammarScreen({super.key});

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
            // TODO: Add CountdownBar

            // Offset
            SizedBox(height: 30),

            // Grammar Minigame Instructions
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: kSubtext20,
                children: [
                  TextSpan(
                    text: 'Identify if the sentence\nis ',
                  ),
                  TextSpan(
                      text: 'grammatically correct.', style: kFontWeightBold),
                ],
              ),
            ),

            // Offset
            SizedBox(height: 30),

            // Grammar Question
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'She was walking down the street when she seen a dog that was barking loudly at it\'s owner.',
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
                    onPressed: () {},
                    child: Center(
                      child: Text('CORRECT', style: kButtonTextStyle),
                    ),
                  ),
                  OvalButton(
                    color: Colors.white,
                    borderColor: kOrangeColor600,
                    onPressed: () {},
                    child: Center(
                      child: Text('INCORRECT', style: kButtonTextStyleOrange),
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
