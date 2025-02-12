import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/services/firebase_auth_service.dart';
import 'package:diction_dash/screens/authentication/auth_manager.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';
import 'package:diction_dash/widgets/text_fields/profile_text_form_field.dart';
import 'package:diction_dash/widgets/loading_indicators/fox_loading_indicator.dart';

// TODO: Save user information with cloud firestore.
// TODO: Modularize _isValidEmail & _isValidPassword

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Firebase Authentication Instance
  final AuthService _auth = AuthService();

  // Registration Form Key
  final _registrationFormKey = GlobalKey<FormState>();

  // Form Fields
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  // Check If Email Matches Requirements
  bool _isValidEmail(String email) {
    String emailFormat = r'[\w+]*@[\w.]*';
    return RegExp(emailFormat).hasMatch(email);
  }

  // Check If Password Matches Requirements
  bool _isValidPassword(String password) {
    bool lengthCheck = password.length >= 8;

    String passwordFormat =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_]).{8,}$';
    bool formatCheck = RegExp(passwordFormat).hasMatch(password);

    print('Length Check: $lengthCheck');
    print('Format Check: $formatCheck');

    return lengthCheck && formatCheck;
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

              // Registration Form
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _registrationFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Instruction Text
                      const Text('   Register your account',
                          style: kOswaldXSmall),

                      // Username Field
                      ProfileTextFormField(
                        icon: Icons.person,
                        hintText: 'Username',
                        validator: (value) {

                          // Check if username is null or empty
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty) {
                            return 'Please provide a username.';

                          // Check if username is shorter than 3 characters
                          } else if (value.length < 3) {
                            return 'Please provide a longer username.';
                          }

                          // Return null if username is valid (this validates this field)
                          return null;
                        },
                        onSaved: (value) {
                          _username = value!;
                        },
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
                            return 'Please provide a password.';

                          // Check if password meets requirements
                          } else if (!_isValidPassword(value)) {
                            print(value);
                            print(!_isValidPassword(value));
                            // TODO: Validation message should only mention what is necessary
                            return 'Please provide a valid password.\n'
                                '- Minimum 8 Characters\n'
                                '- Minimum 1 Upper case\n'
                                '- Minimum 1 Lowercase\n'
                                '- Minimum 1 Number\n'
                                '- Minimum 1 Special Character';
                          }

                          // Return null if password is valid (this validates this field)
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),

                      // Confirm Password Field
                      ProfileTextFormField(
                        icon: Icons.lock,
                        hintText: 'Confirm Password',
                        obscureText: true,
                        validator: (value) {

                          // Check if confirm password is null or empty
                          if (value == null || value.isEmpty) {
                            return 'Please confirm password.';
                          }

                          // Return null if confirm password is valid (this validates this field)
                          return null;
                        },
                        onSaved: (value) {
                          _confirmPassword = value!;
                        },
                      ),

                      // Register Button
                      RoundedRectangleButton(

                        // TODO: If possible, create separate function for this.

                        onPressed: () async {
                          // Get Form Data
                          FormState formData =
                              _registrationFormKey.currentState!;

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
                            await _auth.registerUser(
                                email: _email, password: _password);

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
                          child: Text('REGISTER', style: kButtonTextStyle),
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
