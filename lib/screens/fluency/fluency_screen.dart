import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/screens/fluency/feedback_screen.dart';
import 'package:diction_dash/widgets/buttons/oval_info_button.dart';
import 'package:diction_dash/services/auth_service.dart';
import 'package:diction_dash/services/firestore_service.dart';

// TODO: Redirect to feedback screen on button press
// TODO: Save selected fluency level on Firebase on button press

class FluencyScreen extends StatefulWidget {
  const FluencyScreen({super.key});

  @override
  State<FluencyScreen> createState() => _FluencyScreenState();
}

class _FluencyScreenState extends State<FluencyScreen> {

  // Firebase Authentication Instance
  final AuthService _auth = AuthService();

  // Cloud Firestore Instance
  final FirestoreService _firestore = FirestoreService();

  Future<void> _updateFluency(BuildContext context, {required String fluency}) async {

    await _firestore.updateFluency(userID: _auth.currentUserID, fluency: fluency);

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
              onPressed: () => _updateFluency(context, fluency: 'BEGINNER'),
            ),

            // Elementary Fluency Button
            OvalInfoButton(
              text: 'ELEMENTARY',
              infoDescription:
              'I can understand simple spoken English and basic written texts.',
              onPressed: () => _updateFluency(context, fluency: 'ELEMENTARY'),
            ),

            // Intermediate Fluency Button
            OvalInfoButton(
              text: 'INTERMEDIATE',
              infoDescription:
              'I can hold basic conversations, read, and write with some errors.',
              onPressed: () => _updateFluency(context, fluency: 'INTERMEDIATE'),
            ),

            // Advanced Fluency Button
            OvalInfoButton(
              text: 'ADVANCED',
              infoDescription:
              'I can understand and engage in various topics, and read and write effectively with minimal errors.',
              onPressed: () => _updateFluency(context, fluency: 'ADVANCED'),
            ),

            // Expert Fluency Button
            OvalInfoButton(
              text: 'EXPERT',
              infoDescription:
              'I am fluent in English, capable of understanding complex texts and engaging in advanced conversations effortlessly.',
              onPressed: () => _updateFluency(context, fluency: 'EXPERT'),
            ),
          ],
        ),
      ),
    );
  }
}
