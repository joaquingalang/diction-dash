import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/buttons/oval_info_button.dart';

// TODO: Redirect to feedback screen on button press
// TODO: Save selected fluency level on Firebase on button press

class FluencyScreen extends StatelessWidget {
  const FluencyScreen({super.key});

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
            Image.asset('assets/images/logo.png', width: 250),

            // Offset
            SizedBox(height: 15),

            // Beginner Fluency Button
            OvalInfoButton(
              text: 'BEGINNER',
              infoDescription:
                  'I know a few words and phrases but struggle with basic sentences.',
              onPressed: () {},
            ),

            // Elementary Fluency Button
            OvalInfoButton(
              text: 'ELEMENTARY',
              infoDescription:
              'I know a few words and phrases but struggle with basic sentences.',
              onPressed: () {},
            ),

            // Intermediate Fluency Button
            OvalInfoButton(
              text: 'INTERMEDIATE',
              infoDescription:
              'I know a few words and phrases but struggle with basic sentences.',
              onPressed: () {},
            ),

            // Advanced Fluency Button
            OvalInfoButton(
              text: 'ADVANCED',
              infoDescription:
              'I know a few words and phrases but struggle with basic sentences.',
              onPressed: () {},
            ),

            // Expert Fluency Button
            OvalInfoButton(
              text: 'EXPERT',
              infoDescription:
              'I know a few words and phrases but struggle with basic sentences.',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
