import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/screens/fluency/feedback_screen.dart';
import 'package:diction_dash/widgets/buttons/oval_info_button.dart';

// TODO: Redirect to feedback screen on button press
// TODO: Save selected fluency level on Firebase on button press

class FluencyScreen extends StatelessWidget {
  const FluencyScreen({super.key});

  void _feedbackScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeedbackScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Page App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: Image.asset(
          'assets/images/diction_dash.png',
          width: kAppBarTitleSize,
        ),
        centerTitle: true,
      ),

      // Page Body
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [

            // Offset
            SizedBox(height: 15),

            // Fox Logo
            Hero(
              tag: 'app-logo',
              child: Image.asset(
                'assets/images/logo.png',
                width: 250,
              ),
            ),

            // Offset
            SizedBox(height: 15),

            // Beginner Fluency Button
            OvalInfoButton(
              text: 'BEGINNER',
              infoDescription:
                  'I know a few words and phrases but struggle with basic sentences.',
              onPressed: () => _feedbackScreen(context),
            ),

            // Elementary Fluency Button
            OvalInfoButton(
              text: 'ELEMENTARY',
              infoDescription:
              'I know a few words and phrases but struggle with basic sentences.',
              onPressed: () => _feedbackScreen(context),
            ),

            // Intermediate Fluency Button
            OvalInfoButton(
              text: 'INTERMEDIATE',
              infoDescription:
              'I know a few words and phrases but struggle with basic sentences.',
              onPressed: () => _feedbackScreen(context),
            ),

            // Advanced Fluency Button
            OvalInfoButton(
              text: 'ADVANCED',
              infoDescription:
              'I know a few words and phrases but struggle with basic sentences.',
              onPressed: () => _feedbackScreen(context),
            ),

            // Expert Fluency Button
            OvalInfoButton(
              text: 'EXPERT',
              infoDescription:
              'I know a few words and phrases but struggle with basic sentences.',
              onPressed: () => _feedbackScreen(context),
            ),
          ],
        ),
      ),
    );
  }
}
