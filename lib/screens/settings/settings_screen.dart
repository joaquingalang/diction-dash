import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/widgets/list_tiles/setting_tile.dart';
import 'package:diction_dash/widgets/list_tiles/switch_setting_tile.dart';

// TODO: Integrate shared preferences

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  // Toggle Variables
  bool _notifsEnabled = true;
  bool _capslockEnabled = true;
  bool _soundsEnabled = true;

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
        title: Text('Settings', style: kOswaldMedium),
      ),

      // Page Body
      body: SafeArea(
        child: Column(
          children: [
            SettingTile(
              title: 'Profile',
              iconData: Icons.person,
              onTap: () {},
            ),
            SettingTile(
              title: 'Preferences',
              iconData: Icons.photo,
              onTap: () {},
            ),
            SwitchSettingTile(
              title: 'Notifications',
              iconData: Icons.notifications,
              value: _notifsEnabled,
              onChanged: (value) {
                setState(() {
                  _notifsEnabled = value;
                });
              },
            ),
            SwitchSettingTile(
              title: 'Auto caps-lock',
              iconData: Icons.notifications,
              value: _capslockEnabled,
              onChanged: (value) {
                setState(() {
                  _capslockEnabled = value;
                });
              },
            ),
            SwitchSettingTile(
              title: 'Sounds',
              iconData: Icons.volume_up,
              value: _soundsEnabled,
              onChanged: (value) {
                setState(() {
                  _soundsEnabled = value;
                });
              },
            ),
            SettingTile(
              title: 'FAQ',
              iconData: Icons.help,
              onTap: () {},
            ),
            SettingTile(
              title: 'Help & Support',
              iconData: Icons.info,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
