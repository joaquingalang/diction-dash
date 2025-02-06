import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/progress_bars/question_bar.dart';
import 'package:diction_dash/widgets/progress_bars/countdown_bar.dart';
import 'package:diction_dash/widgets/buttons/oval_button.dart';

// TODO: Separate Screen with Question

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key});

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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  OvalButton(
                    onPressed: () {},
                    child: Center(
                      child: Text('mystic', style: kButtonTextStyle),
                    ),
                  ),
                  OvalButton(
                    onPressed: () {},
                    child: Center(
                      child: Text('demure', style: kButtonTextStyle),
                    ),
                  ),
                  OvalButton(
                    onPressed: () {},
                    child: Center(
                      child: Text('unique', style: kButtonTextStyle),
                    ),
                  ),
                  OvalButton(
                    onPressed: () {},
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
