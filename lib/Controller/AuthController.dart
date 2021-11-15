// @dart=2.9
import 'package:e_commerce_app/models/UserModel.dart';
import 'package:e_commerce_app/service/FireStoreUser.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:e_commerce_app/widgets/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin = FacebookLogin();
  String email = "", password = "", name = "";

  //ToDo:
  final _user = Rx<User>();

  String get user => _user.value?.email;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // any change in _auth bind the result to _user
    _user.bindStream(_auth.authStateChanges());
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
    final GoogleSignInAccount googleuser = await _googleSignIn.signIn();
    Get.offAll(HomeView());

    //print(googleuser);

    // save google email after signin in firebase
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleuser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    await _auth.signInWithCredential(credential);

    //print("google user : $googleuser");
  }

  void facebookSignInMethod() async {
    FacebookLoginResult result = await _facebookLogin.logIn(['email']);

    final accessToken = result.accessToken.token;
    if (result.status == FacebookLoginStatus.loggedIn) {
      final facebookcredential = FacebookAuthProvider.credential(accessToken);
      await _auth.signInWithCredential(facebookcredential);
    }
  }

  void SignInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password); // .then((value) => print(value));
      Get.offAll(() => HomeView());
    } catch (e) {
      Get.snackbar('Error Login Account', e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }

  void CreateAccount() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        UserModel userModel = UserModel(
            userId: user.user.uid, email: user.user.email, name: name, pic: '');
        SaveUserToFireStore(userModel);
      }); // .then((value) => print(value));
      Get.offAll(() => HomeView());
    } catch (e) {
      Get.snackbar('Error Login Account', e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }

  SaveUserToFireStore(UserModel userModel) async {
    await FireStoreUser().AddUserToFireStore(userModel);
  }
}
