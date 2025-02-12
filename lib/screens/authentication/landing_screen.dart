import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/screens/authentication/login_screen.dart';
import 'package:diction_dash/screens/authentication/register_screen.dart';
import 'package:diction_dash/widgets/buttons/oval_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // White Semi-Circle Backdrop Size Relative To Screen Height
    final double fixedSize = MediaQuery.of(context).size.height / 4.5;

    return Scaffold(
      // Page Background Color
      backgroundColor: kOrangeColor600,

      // Page Body
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            // Fox Logo & Welcome Message
            Expanded(
              flex: 4,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [

                    // White Semi-Circle Backdrop
                    Transform.scale(
                      scale: 4.5,
                      child: Container(
                        width: fixedSize,
                        height: fixedSize,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    // Fox Logo & Welcome Message
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Fox Logo
                        Hero(
                          tag: 'app-logo',
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 300,
                          ),
                        ),

                        // Welcome Message
                        Text(
                          'WELCOME TO',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Oswald',
                            color: kGrayColor600,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 6,
                          ),
                        ),

                        // Diction Dash Text Logo
                        Image.asset('assets/images/diction_dash.png',
                            width: 350)
                      ],
                    )
                  ],
                ),
              ),
            ),

            // Login & Register Buttons
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OvalButton(
                    color: Colors.white,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'LOG IN',
                        style: kOrangeButtonTextStyle,
                      ),
                    ),
                  ),
                  OvalButton(
                    borderColor: Colors.white,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'REGISTER',
                        style: kButtonTextStyle,
                      ),
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
