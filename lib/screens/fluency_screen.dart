import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/buttons/oval_info_button.dart';

class FluencyScreen extends StatelessWidget {
  const FluencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Image.asset('assets/images/logo.png', width: 250),
            SizedBox(height: 15),
            OvalInfoButton(
              text: 'BEGINNER',
              infoDescription:
                  'I know a few words and phrases but struggle with basic sentences.',
              onPressed: () {},
            ),
            OvalInfoButton(
              text: 'ELEMENTARY',
              infoDescription:
              'I know a few words and phrases but struggle with basic sentences.',
              onPressed: () {},
            ),
            OvalInfoButton(
              text: 'INTERMEDIATE',
              infoDescription:
              'I know a few words and phrases but struggle with basic sentences.',
              onPressed: () {},
            ),
            OvalInfoButton(
              text: 'ADVANCED',
              infoDescription:
              'I know a few words and phrases but struggle with basic sentences.',
              onPressed: () {},
            ),
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
