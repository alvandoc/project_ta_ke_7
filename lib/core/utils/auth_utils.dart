
import 'dart:convert';

import 'package:project_ta_ke_7/core/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static AuthUtils instance = AuthUtils();

  void saveSession(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("islogin", true);
    prefs.setString("user", json.encode(user.toMap()));
  }

  Future<bool> checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool("islogin") ?? false;
  }

  Future<UserModel> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await prefs.getString("user");
    return UserModel.fromJson(json.decode(data));
  }

  void clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}