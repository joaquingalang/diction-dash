import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/services/settings_service.dart';
import 'package:diction_dash/screens/settings/profile_screen.dart';
import 'package:diction_dash/widgets/list_tiles/setting_tile.dart';
import 'package:diction_dash/widgets/list_tiles/switch_setting_tile.dart';
import 'package:diction_dash/widgets/loading_indicators/fox_loading_indicator.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Settings Instances
  final SettingsService _settings = SettingsService();

  // Page Loading
  bool _isLoading = true;

  // Toggle Variables
  bool _notifsEnabled = true;
  bool _capslockEnabled = false;
  bool _gameAudioEnabled = true;

  void _initSettings() async {
    // Get Game Audio Setting
    bool gameAudio = await _settings.getGameAudio();

    // Get Capslock Setting
    bool capslock = await _settings.getCapslock();

    setState(() {
      _gameAudioEnabled = gameAudio;
      _capslockEnabled = capslock;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _initSettings();
  }

  @override
  Widget build(BuildContext context) {
    return (!_isLoading)
        ? Scaffold(
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
              title: Text(
                (!_capslockEnabled) ? 'Settings' : 'Settings'.toUpperCase(),
                style: kOswaldMedium,
              ),
            ),

            // Page Body
            body: SafeArea(
              child: Column(
                children: [
                  SettingTile(
                    title: (!_capslockEnabled) ? 'Profile' : 'Profile'.toUpperCase(),
                    iconData: Icons.person,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                    ),
                  ),
                  SettingTile(
                    title: (!_capslockEnabled) ? 'Preferences' : 'Preferences'.toUpperCase(),
                    iconData: Icons.photo,
                    onTap: () {},
                  ),
                  SwitchSettingTile(
                    title: (!_capslockEnabled) ? 'Notifications' : 'Notifications'.toUpperCase(),
                    iconData: Icons.notifications,
                    value: _notifsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notifsEnabled = value;
                      });
                    },
                  ),
                  SwitchSettingTile(
                    title: (!_capslockEnabled) ? 'Auto caps-lock' : 'Auto caps-lock'.toUpperCase(),
                    iconData: Icons.notifications,
                    value: _capslockEnabled,
                    onChanged: (value) {
                      setState(() {
                        _capslockEnabled = value;
                      });
                      _settings.setCapslock(_capslockEnabled);
                    },
                  ),
                  SwitchSettingTile(
                    title: (!_capslockEnabled) ? 'Game Audio' : 'Game Audio'.toUpperCase(),
                    iconData: Icons.volume_up,
                    value: _gameAudioEnabled,
                    onChanged: (value) {
                      setState(() {
                        _gameAudioEnabled = value;
                      });
                      _settings.setGameAudio(_gameAudioEnabled);
                    },
                  ),
                  SettingTile(
                    title: (!_capslockEnabled) ? 'FAQs' : 'FAQs'.toUpperCase(),
                    iconData: Icons.help,
                    onTap: () {},
                  ),
                  SettingTile(
                    title: (!_capslockEnabled) ? 'Help & Support' : 'Help & Support'.toUpperCase(),
                    iconData: Icons.info,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )
        : Foxloadingindicator();
  }
}
