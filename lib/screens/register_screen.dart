import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';
import 'package:diction_dash/widgets/text_fields/profile_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
      body: SafeArea(
        child: Column(
          children: [
            Hero(
              tag: 'app-logo',
              child: Image.asset(
                'assets/images/logo.png',
                width: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('   Register your account', style: kOswaldXSmall),
                  ProfileTextFormField(
                    icon: Icons.person,
                    hintText: 'Username',
                  ),
                  ProfileTextFormField(
                    icon: Icons.mail,
                    hintText: 'Email',
                  ),
                  ProfileTextFormField(
                    icon: Icons.lock,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  ProfileTextFormField(
                    icon: Icons.lock,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  RoundedRectangleButton(
                    onPressed: () {},
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
