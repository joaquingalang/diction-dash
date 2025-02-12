import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/screens/home_screen.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // For Offset
            SizedBox(),

            // Fox Logo & Feedback Message
            Column(
              children: [
                Hero(
                  tag: 'app-logo',
                  child: Image.asset(
                    'assets/images/logo_eyes_closed.png',
                    width: 250,
                  ),
                ),
                Text(
                  'THANK YOU\nFOR YOUR FEEDBACK',
                  style: kOswaldMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 100),
                Text(
                  'Your proficiency level will be adjusted\naccordingly, to provide better learning\ninteractivity! You can adjust the difficulty\nlevel in the settings in the future if needed.',
                  style: kGraySubtext18,
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            // For Offset
            SizedBox(),

            // Proceed To Next Page Button
            RoundedRectangleButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              ),
              child: Center(
                child: Text(
                  'PROCEED',
                  style: kButtonTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
