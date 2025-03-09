import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {

  // Get Game Audio Status
  Future<bool> getGameAudio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? audioEnabled = prefs.getBool('audioEnabled');
    audioEnabled ??= true;
    return audioEnabled;
  }

  // Set Game Audio
  void setGameAudio(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('audioEnabled', value);
  }

  // Get Capslock Setting
  Future<bool> getCapslock() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? capslockEnabled = prefs.getBool('capslockEnabled');
    capslockEnabled ??= false;
    return capslockEnabled;
  }

  // Set Capslock Setting
  void setCapslock(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('capslockEnabled', value);
  }

}