import 'dart:convert';

import 'package:flutter_monisite/data/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final String TOKEN = "token";

  void saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TOKEN, token);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefsValue = prefs.getString(TOKEN);
    if (prefsValue == null) {
      return null;
    } else {
      return prefsValue;
    }
  }

  void deleteTokenModel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN);
    await prefs.clear();
    print("TokenModel " + prefs.getString(TOKEN).toString());
  }
}
