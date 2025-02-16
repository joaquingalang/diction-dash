import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/utils/form_validators.dart';
import 'package:diction_dash/services/auth_service.dart';
import 'package:diction_dash/screens/authentication/auth_manager.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';
import 'package:diction_dash/widgets/text_fields/profile_text_form_field.dart';
import 'package:diction_dash/widgets/loading_indicators/fox_loading_indicator.dart';
import 'package:diction_dash/screens/authentication/password_reset_screen.dart';

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

  Future<void> _login() async {
    // Get Form Data
    FormState formData = _loginFormKey.currentState!;

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
  }

  void _forgotPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordResetScreen(),
      ),
    );
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
                        child:
                            Text('   Login your account', style: kOswaldXSmall),
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
                        validator: validateLoginPassword,
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => _forgotPassword(context),
                          child: Text(
                            'Forgot Password   ',
                            style: kSubtext15,
                          ),
                        ),
                      ),

                      // Login Button
                      RoundedRectangleButton(
                        onPressed: _login,
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
