import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/services/auth_service.dart';
import 'package:diction_dash/screens/authentication/auth_manager.dart';
import 'package:diction_dash/widgets/text_fields/profile_edit_text_field.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';

class UpdatePasswordSheet extends StatefulWidget {
  const UpdatePasswordSheet({
    super.key,
  });

  @override
  State<UpdatePasswordSheet> createState() => _UpdatePasswordSheetState();
}

class _UpdatePasswordSheetState extends State<UpdatePasswordSheet> {

  // Firebase Authentication Instance
  final AuthService _auth = AuthService();

  // Password Text Controllers
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _changePassword() async {

    // Dismiss Keyboard
    FocusScope.of(context).unfocus();

    // Text Controllers
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Check if new password matches with confirm password
    if (newPassword == confirmPassword) {
      await _auth.updatePassword(currentPassword: currentPassword, newPassword: newPassword);
    } else {
      // TODO: Let user know that the new password and confirm password does not match!
      print('Passwords do not match!');
    }
  }

  Future<void> _logout() async {
    // Auth Logout
    await _auth.logout();

    // Return To AuthManager Without Route History
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => AuthManager(),
      ),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 480,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            // Offset
            SizedBox(height: 10),

            // Bottom Sheet Draggable Bar
            Container(
              width: 80,
              height: 5,
              decoration: BoxDecoration(
                color: kGrayColor500,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            // Offset
            SizedBox(height: 15),

            // Sheet Purpose
            Text(
              'Change Password',
              style: kSubtext20.copyWith(fontWeight: FontWeight.bold),
            ),

            // Current Password Field
            ProfileEditTextField(
              labelText: 'CURRENT PASSWORD',
              controller: _currentPasswordController,
              obscureText: true,
            ),

            // Current Password Field
            ProfileEditTextField(
              labelText: 'NEW PASSWORD',
              controller: _newPasswordController,
              obscureText: true,
            ),

            // Current Password Field
            ProfileEditTextField(
              labelText: 'CONFIRM PASSWORD',
              controller: _confirmPasswordController,
              obscureText: true,
            ),

            // Offset
            Expanded(child: SizedBox(height: 15)),

            // Continue Button
            RoundedRectangleButton(
              onPressed: () {
                Navigator.pop(context);
                _changePassword();
                _logout();
              },
              child: Center(
                child: Text('CONTINUE', style: kButtonTextStyle),
              ),
            ),

            // Offset
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
