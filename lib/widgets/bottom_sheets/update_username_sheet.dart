import 'package:diction_dash/services/auth_service.dart';
import 'package:diction_dash/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/text_fields/profile_edit_text_field.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';

class UpdateUsernameSheet extends StatefulWidget {
  const UpdateUsernameSheet({
    super.key,
    required this.username,
  });

  final String username;

  @override
  State<UpdateUsernameSheet> createState() => _UpdateUsernameSheetState();
}

class _UpdateUsernameSheetState extends State<UpdateUsernameSheet> {

  // Firebase Authentication Instance
  final AuthService _auth = AuthService();

  // Cloud Firestore Instance
  final FirestoreService _firestore = FirestoreService();

  // Text Controllers
  final TextEditingController _newUsernameController = TextEditingController();

  void _updateUsername() {
    _firestore.updateUsername(userID: _auth.currentUserID, newUsername: _newUsernameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
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
              'Change Username',
              style: kSubtext20.copyWith(fontWeight: FontWeight.bold),
            ),

            // New Username Field
            ProfileEditTextField(
              labelText: 'NEW USERNAME',
              initialValue: widget.username,
              controller: _newUsernameController,
            ),

            // Continue Button
            RoundedRectangleButton(
              onPressed: () {

                // Update The Password
                _updateUsername();

                // Navigator
                Navigator.pop(context);

              },
              child: Center(
                child: Text('CONTINUE', style: kButtonTextStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
