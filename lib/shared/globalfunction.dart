import 'package:e_commerce_app/helper/homeviewbinding.dart';
import 'package:e_commerce_app/helper/localStorageUserData.dart';
import 'package:e_commerce_app/layout/layout.dart';
import 'package:e_commerce_app/models/UserModel.dart';
import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

void saveuserThenNavigate(UserModel userModel) {
  currentuserModel = userModel;
  LocalStorageUserData.setUser(userModel);
  Get.offAll(
    () => EcommerceLayout(),
    binding: HomeViewBinding(),
  );
}

SignOut() async {
  GoogleSignIn().signOut();
  FacebookLogin().logOut();
  await FirebaseAuth.instance.signOut();
  await LocalStorageUserData.deleteUser();
  Get.off(LoginView());
}
