
import 'dart:convert';

import 'package:e_commerce_app/models/UserModel.dart';
import 'package:e_commerce_app/shared/Constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageUserData {
  static SharedPreferences? sharedPreferences;

  static Init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<UserModel?> getuserData() async {
    try {
      var userModel = await sharedPreferences?.getString(localUserData);

      if (userModel == null) return null;

      return UserModel.fromjson(json.decode(userModel));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> setUser(UserModel model) async {
    await sharedPreferences?.setString(
        localUserData, json.encode(model.tojson()));
  }

  static Future deleteUser() async {
    await sharedPreferences?.clear();
    currentuserModel = null;
  }
}
