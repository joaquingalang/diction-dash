import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';
import 'package:diction_dash/widgets/text_fields/profile_text_form_field.dart';

// TODO: Add user registration logic with firebase authentication.
// TODO: Save user information with cloud firestore.

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
          children: [

            // Fox Hero Logo
            Hero(
              tag: 'app-logo',
              child: Image.asset(
                'assets/images/logo.png',
                width: 250,
              ),
            ),

            // Registration Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Instruction Text
                  const Text('   Register your account', style: kOswaldXSmall),

                  // Username Field
                  ProfileTextFormField(
                    icon: Icons.person,
                    hintText: 'Username',
                  ),

                  // EMail Field
                  ProfileTextFormField(
                    icon: Icons.mail,
                    hintText: 'Email',
                  ),

                  // Password Field
                  ProfileTextFormField(
                    icon: Icons.lock,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  // Confirm Password Field
                  ProfileTextFormField(
                    icon: Icons.lock,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),

                  // Register Button
                  RoundedRectangleButton(
                    onPressed: () {},
                    child: Center(
                      child: Text('REGISTER', style: kButtonTextStyle),
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
