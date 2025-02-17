import 'package:diction_dash/screens/authentication/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/utils/form_validators.dart';
import 'package:diction_dash/services/auth_service.dart';
import 'package:diction_dash/widgets/text_fields/profile_text_form_field.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';
import 'package:diction_dash/widgets/loading_indicators/fox_loading_indicator.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  // Firebase Authentication Instance
  final AuthService _auth = AuthService();

  // Login Form Key
  final _passwordResetFormKey = GlobalKey<FormState>();
  String _email = '';

  Future<void> _passwordReset() async {
    // Get Form Data
    FormState formData = _passwordResetFormKey.currentState!;

    // Validate Form Data
    if (formData.validate()) {
      // Save Form State
      formData.save();

      // TODO: Check if passwords match

      // Show Loading Indicator
      showDialog(
        context: context,
        builder: (context) => Foxloadingindicator(),
      );

      // Register User w/ Email & Password
      await _auth.passwordReset(email: _email);

      // Pop Loading Indicator
      Navigator.pop(context);

      // Navigate Back To AuthManager
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthManager(),
        ),
      );
    }
  }

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
        scrolledUnderElevation: 0,
      ),

      // Page Body
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            spacing: 35,
            children: [
              // Fox Hero Logo
              Hero(
                tag: 'app-logo',
                child: Image.asset(
                  'assets/images/logo_eyes_closed.png',
                  width: 250,
                ),
              ),

              // Page Message
              Column(
                children: [
                  Text(
                    'Forgot your password?',
                    style: kOswaldMedium,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'No worries! We\'ll send you\nreset instructions',
                    style: kSubtext20,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              // Login Form
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _passwordResetFormKey,
                  child: Column(
                    children: [
                      // Instruction Text
                      Align(
                        alignment: Alignment.centerLeft,
                        child:
                            Text('   Enter your email', style: kOswaldXSmall),
                      ),

                      // Email Field
                      ProfileTextFormField(
                        icon: Icons.mail,
                        hintText: 'Email',
                        validator: validateEmail,
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),

                      // Login Button
                      RoundedRectangleButton(
                        onPressed: _passwordReset,
                        child: Center(
                          child: Text('SEND EMAIL', style: kButtonTextStyle),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
