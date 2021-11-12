//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:e_commerce_app/widgets/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthViewModel extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  //FacebookLogin _facebookLogin = FacebookLogin();
  String email = "", password = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void googleSignInMethod() async {
    // sign in with google
    final GoogleSignInAccount? googleuser = await _googleSignIn.signIn();

    print(googleuser);

    // save google email after signin in firebase
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleuser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    await _auth.signInWithCredential(credential);
    //print("google user : $googleuser");
  }

  // void facebookSignInMethod() async {
  //   FacebookLoginResult result =
  //       await _facebookLogin.logInWithReadPermissions(['email']);

  //   final accessToken = result.accessToken.token;
  //   if (result.status == FacebookLoginStatus.loggedIn) {
  //     final facebookcredential = FacebookAuthProvider.credential(accessToken);
  //     await _auth.signInWithCredential(facebookcredential);
  //   }
  // }

  void SignInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password); // .then((value) => print(value));
      Get.offAll(HomeView());
    } catch (e) {
      Get.snackbar('Error Login Account', e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
