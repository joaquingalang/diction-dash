import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';
import 'package:diction_dash/widgets/text_fields/profile_text_form_field.dart';
import 'package:diction_dash/screens/home_screen.dart';

// TODO: Add login logic with firebase authentication.

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Page App Bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
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
      ),

      // Page Body
      body: SafeArea(
        child: Column(
          children: [
            // Fox Hero Logo
            Hero(
              tag: 'app-logo',
              child: Image.asset(
                'assets/images/logo.png',
                width: 250,
              ),
            ),

            // Login Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  // Instruction Text
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('   Login your account', style: kOswaldXSmall),
                  ),

                  // Email Field
                  ProfileTextFormField(
                    icon: Icons.mail,
                    hintText: 'Email',
                  ),

                  // Password Field
                  ProfileTextFormField(
                    icon: Icons.lock,
                    hintText: 'Password',
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password   ',
                      style: kSubtext15,
                    ),
                  ),

                  // Login Button
                  RoundedRectangleButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    ),
                    child: Center(
                      child: Text('LOGIN', style: kButtonTextStyle),
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
