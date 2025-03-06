import 'package:diction_dash/widgets/loading_indicators/fox_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/utils/constants.dart';
import 'package:diction_dash/services/settings_service.dart';
import 'package:diction_dash/screens/settings/profile_screen.dart';
import 'package:diction_dash/widgets/list_tiles/setting_tile.dart';
import 'package:diction_dash/widgets/list_tiles/switch_setting_tile.dart';

// TODO: Integrate shared preferences

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
  bool _capslockEnabled = true;
  bool _gameAudioEnabled = true;

  void _initSettings() async {
    bool? gameAudio = await _settings.getGameAudio();
    setState(() {
      _gameAudioEnabled = gameAudio;
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
              title: Text('Settings', style: kOswaldMedium),
            ),

            // Page Body
            body: SafeArea(
              child: Column(
                children: [
                  SettingTile(
                    title: 'Profile',
                    iconData: Icons.person,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                    ),
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
                    title: 'Game Audio',
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
          )
        : Foxloadingindicator();
  }
}
