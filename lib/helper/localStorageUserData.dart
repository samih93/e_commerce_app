// @dart=2.9

import 'dart:convert';

import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/models/UserModel.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class localStorageUserData extends GetxController {
  Future<UserModel> get getuserData async {
    try {
      UserModel userModel = await _getUserData();
      if (userModel == null) return null;

      return userModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  setUser(UserModel model) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // await pref.setString(localUserData, json.encode(model.tojson()));
    await pref.setString(localUserData, json.encode(model.tojson()));
    // print("Set user " + json.encode(model.tojson()));
  }

  _getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userdata = await pref.getString(localUserData);
    return UserModel.fromjson(json.decode(userdata));
  }

  deleteUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
