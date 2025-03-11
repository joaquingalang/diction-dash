import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/services/auth_service.dart';
import 'package:diction_dash/services/firestore_service.dart';
import 'package:diction_dash/screens/authentication/auth_manager.dart';
import 'package:diction_dash/widgets/text_fields/profile_edit_text_field.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';

class DeleteAccountSheet extends StatefulWidget {
  const DeleteAccountSheet({
    super.key,
  });

  @override
  State<DeleteAccountSheet> createState() => _DeleteAccountSheetState();
}

class _DeleteAccountSheetState extends State<DeleteAccountSheet> {
  // Firebase Authentication Instance
  final AuthService _auth = AuthService();

  final FirestoreService _firestore = FirestoreService();

  // Password Text Editing Controller
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _deleteAccount() async {

    // Dismiss Keyboard
    FocusScope.of(context).unfocus();

    String password = _passwordController.text;
    String userID = _auth.currentUserID;
    await _auth.deleteUser(password: password);
    await _firestore.deleteUser(userID: userID);
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
      height: 440,
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
              'Account Deletion',
              style: kSubtext20.copyWith(fontWeight: FontWeight.bold),
            ),

            // Offset
            SizedBox(height: 15),

            Text(
              'Are you sure you want to\ndelete your account? Once you\ndelete it, you cannot get it back.\n\nEnter your password to confirm.',
              style: kSubtext20,
              textAlign: TextAlign.center,
            ),

            // Offset
            SizedBox(height: 15),

            // Current Password Field
            ProfileEditTextField(
              labelText: 'PASSWORD',
              controller: _passwordController,
              obscureText: true,
            ),

            // Continue Button
            RoundedRectangleButton(
              backgroundColor: Colors.red,
              onPressed: () async {
                await _deleteAccount();
                _logout();
              },
              child: Center(
                child: Text('DELETE', style: kButtonTextStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
