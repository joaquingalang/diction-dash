import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/utils/form_validators.dart';
import 'package:diction_dash/services/firebase_auth_service.dart';
import 'package:diction_dash/screens/authentication/auth_manager.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';
import 'package:diction_dash/widgets/text_fields/profile_text_form_field.dart';
import 'package:diction_dash/widgets/loading_indicators/fox_loading_indicator.dart';

// TODO: Save user information with cloud firestore.

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

  Future<void> _register() async {
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
                        validator: validateUsername,
                        onSaved: (value) {
                          _username = value!;
                        },
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

                      // Password Field
                      ProfileTextFormField(
                        icon: Icons.lock,
                        hintText: 'Password',
                        obscureText: true,
                        validator: validateRegisterPassword,
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),

                      // Confirm Password Field
                      ProfileTextFormField(
                        icon: Icons.lock,
                        hintText: 'Confirm Password',
                        obscureText: true,
                        validator: validateConfirmPassword,
                        onSaved: (value) {
                          _confirmPassword = value!;
                        },
                      ),

                      // Register Button
                      RoundedRectangleButton(
                        onPressed: _register,
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
