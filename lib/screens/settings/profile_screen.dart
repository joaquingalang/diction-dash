import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/buttons/profile_picture_edit_button.dart';
import 'package:diction_dash/widgets/buttons/profile_edit_button.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';
import 'package:diction_dash/widgets/bottom_sheets/update_username_sheet.dart';
import 'package:diction_dash/widgets/bottom_sheets/update_password_sheet.dart';
import 'package:diction_dash/widgets/bottom_sheets/delete_account_sheet.dart';
import 'package:diction_dash/screens/fluency/fluency_screen.dart';
import 'package:diction_dash/screens/authentication/landing_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _updateUsername(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => UpdateUsernameSheet(),
    );
  }

  void _updatePassword(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => UpdatePasswordSheet(),
    );
  }

  void _deleteAccount(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => DeleteAccountSheet(),
    );
  }

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
                  text: 'USERNAME', labelText: 'Alice Guo', onTap: () => _updateUsername(context)),

              // Change Password
              ProfileEditButton(
                  text: 'PASSWORD', labelText: '**********', onTap: () => _updatePassword(context)),

              // Adjust Fluency
              RoundedRectangleButton(
                backgroundColor: kGrayColor300,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FluencyScreen(),
                  ),
                ),
                child: Center(
                  child: Text('ADJUST FLUENCY', style: kButtonTextStyle),
                ),
              ),

              // Delete Account
              RoundedRectangleButton(
                backgroundColor: kGrayColor300,
                onPressed: () => _deleteAccount(context),
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
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LandingScreen(),
                  ),
                ),
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

