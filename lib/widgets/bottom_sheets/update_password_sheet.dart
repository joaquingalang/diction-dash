import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
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
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 490,
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
              initialValue: '************',
              controller: _currentPasswordController,
              obscureText: true,
            ),

            // Current Password Field
            ProfileEditTextField(
              labelText: 'NEW PASSWORD',
              initialValue: '************',
              controller: _newPasswordController,
              obscureText: true,
            ),

            // Current Password Field
            ProfileEditTextField(
              labelText: 'CONFIRM PASSWORD',
              initialValue: '************',
              controller: _confirmPasswordController,
              obscureText: true,
            ),

            // Offset
            SizedBox(height: 30),

            // Continue Button
            RoundedRectangleButton(
              onPressed: () {},
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
