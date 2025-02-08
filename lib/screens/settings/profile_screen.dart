import 'package:diction_dash/widgets/buttons/profile_edit_button.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/buttons/profile_picture_edit_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Page App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 35,
          ),
        ),
        title: Text('Profile', style: kOswaldMedium),
      ),

      // Page Body
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              // Edit Profile Picture
              ProfilePictureEditButton(onTap: () {}),

              // Edit Username
              ProfileEditButton(
                  text: 'USERNAME', labelText: 'Alice Guo', onTap: () {}),

              // Change Password
              ProfileEditButton(
                  text: 'PASSWORD', labelText: '**********', onTap: () {}),

              // Adjust Fluency
              RoundedRectangleButton(
                backgroundColor: kGrayColor300,
                onPressed: () {},
                child: Center(
                  child: Text('ADJUST FLUENCY', style: kButtonTextStyle),
                ),
              ),

              // Delete Account
              RoundedRectangleButton(
                backgroundColor: kGrayColor300,
                onPressed: () {},
                child: Center(
                  child: Text('DELETE ACCOUNT', style: kButtonTextStyle),
                ),
              ),

              // Expanded Offset
              Expanded(
                child: SizedBox(height: 30),
              ),

              // Logout Button
              RoundedRectangleButton(
                onPressed: () {},
                child: Center(
                  child: Text('LOGOUT', style: kButtonTextStyle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
