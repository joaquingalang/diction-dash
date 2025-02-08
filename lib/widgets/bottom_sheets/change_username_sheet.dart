import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/text_fields/profile_edit_text_field.dart';

class ChangeUsernameSheet extends StatefulWidget {
  const ChangeUsernameSheet({
    super.key,
  });

  @override
  State<ChangeUsernameSheet> createState() => _ChangeUsernameSheetState();
}

class _ChangeUsernameSheetState extends State<ChangeUsernameSheet> {
  final TextEditingController _newUsernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
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

            Text(
              'Change Username',
              style: kSubtext20.copyWith(fontWeight: FontWeight.bold),
            ),

            ProfileEditTextField(
              labelText: 'NEW USERNAME',
              initialValue: 'Alice Guo',
              controller: _newUsernameController,
            ),

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
