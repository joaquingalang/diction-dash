import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/services/firebase_auth_service.dart';
import 'package:diction_dash/screens/authentication/auth_manager.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';
import 'package:diction_dash/widgets/text_fields/profile_text_form_field.dart';
import 'package:diction_dash/widgets/loading_indicators/fox_loading_indicator.dart';

// TODO: Add login logic with firebase authentication.
// TODO: Modularize _isValidEmail

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // Firebase Authentication Instance
  final AuthService _auth = AuthService();

  // Login Form Key
  final _loginFormKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  // Check If Email Matches Requirements
  bool _isValidEmail(String email) {
    String emailFormat = r'[\w+]*@[\w.]*';
    return RegExp(emailFormat).hasMatch(email);
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
                child: Form(
                  key: _loginFormKey,
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
                        validator: (value) {

                          // Check if email is null or empty
                          if (value == null || value.isEmpty) {
                            return 'Please provide an email.';

                          // Check if email meets requirements
                          } else if (!_isValidEmail(value)) {
                            return 'Please provide a valid email.';
                          }

                          // Return null if email is valid (this validates this field)
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),

                      // Password Field
                      ProfileTextFormField(
                        icon: Icons.lock,
                        hintText: 'Password',
                        obscureText: true,
                        validator: (value) {

                          // Check if password is null or empty
                          if (value == null || value.isEmpty) {
                            return 'Invalid password.';
                          }

                          // Return null if password is valid (this validates this field)
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
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
                        onPressed: () async {
                          // Get Form Data
                          FormState formData =
                          _loginFormKey.currentState!;

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
                            await _auth.loginUser(email: _email, password: _password);

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
                        },
                        child: Center(
                          child: Text('LOGIN', style: kButtonTextStyle),
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
