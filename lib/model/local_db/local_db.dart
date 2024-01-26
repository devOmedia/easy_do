import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  // set the access token
  static setAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("access", token);
  }
}
