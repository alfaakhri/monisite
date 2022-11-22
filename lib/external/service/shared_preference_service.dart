
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final String token = "token";

  void saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(token, token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? prefsValue = prefs.getString(token);
    if (prefsValue == null) {
      return null;
    } else {
      return prefsValue;
    }
  }

  void deleteTokenModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(token);
    await prefs.clear();
    print("TokenModel " + prefs.getString(token).toString());
  }
}
