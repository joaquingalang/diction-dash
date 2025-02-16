import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/services/auth_service.dart';
import 'package:diction_dash/screens/fluency/fluency_screen.dart';
import 'package:diction_dash/screens/authentication/landing_screen.dart';
import 'package:diction_dash/screens/authentication/auth_manager.dart';
import 'package:diction_dash/widgets/buttons/profile_picture_edit_button.dart';
import 'package:diction_dash/widgets/buttons/profile_edit_button.dart';
import 'package:diction_dash/widgets/buttons/rounded_rectangle_button.dart';
import 'package:diction_dash/widgets/bottom_sheets/update_username_sheet.dart';
import 'package:diction_dash/widgets/bottom_sheets/update_password_sheet.dart';
import 'package:diction_dash/widgets/bottom_sheets/delete_account_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _auth = AuthService();

  void _updateUsername(BuildContext context) {
    showModalBottomSheet(
      context: context,

      // Added responsive bottom padding for when keyboard is toggled
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: UpdateUsernameSheet(),
      ),
      isScrollControlled: true,
    );
  }

  void _updatePassword(BuildContext context) {
    showModalBottomSheet(
      context: context,

      // Added responsive bottom padding for when keyboard is toggled
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: UpdatePasswordSheet(),
      ),
      isScrollControlled: true,
    );
  }

  void _deleteAccount(BuildContext context) {
    showModalBottomSheet(
      context: context,

      // Added responsive bottom padding for when keyboard is toggled
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DeleteAccountSheet(),
      ),
      isScrollControlled: true,
    );
  }

  void _logout() async {
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
    return Scaffold(
      // Avoid Keyboard Overflow
      resizeToAvoidBottomInset: false,

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
                onPressed: _logout,
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

