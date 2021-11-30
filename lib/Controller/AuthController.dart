// @dart=2.9

import 'package:e_commerce_app/models/UserModel.dart';
import 'package:e_commerce_app/service/FireStoreUser.dart';
import 'package:e_commerce_app/helper/localStorageUserData.dart';
import 'package:e_commerce_app/views/auth/ControlView.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:e_commerce_app/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  String email = "", password = "", name = "";

  final localStorageUserData local_StorageUserData = Get.find();

  GoogleSignInAccount _googleuser;

  //ToDo:
  final _user = Rx<User>();
  String get user => _user.value?.email;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // any change in _auth bind the result to _user
    _user.bindStream(_auth.authStateChanges());
    if (_auth.currentUser != null) {
      _getCurrentUser(_auth.currentUser.uid);
    }
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

    // save google email after signin in firebase
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleuser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    await _auth.signInWithCredential(credential).then((user) {
      SaveUserToFireStore(user);
    });
    Get.offAll(() => ControlView());

    // saveUserTosharedPreference(new UserModel(
    //   googleuser.,
    // ));

    // saveUserDataTosharedPreference(UserModel(
    //     userId: credential.token.toString(),
    //     email: googleuser.email,
    //     name: googleuser.displayName,
    //     pic: googleuser.photoUrl));
    // print("google user : ${googleuser}");
  }

  void facebookSignInMethod() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    final accessToken = result.accessToken.token;
    if (result.status == FacebookLoginStatus.loggedIn) {
      final facebookcredential = FacebookAuthProvider.credential(accessToken);
      await _auth.signInWithCredential(facebookcredential).then((user) {
        SaveUserToFireStore(user);
      });
      Get.offAll(() => ControlView());
    }
  }

  void SignInWithEmailAndPassword() async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        _getCurrentUser(user.user.uid);
      }); // .then((value) => print(value));
      Get.offAll(() => ControlView());
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
        SaveUserToFireStore(user);
      }); // .then((value) => print(value));
      Get.offAll(() => ControlView());
    } catch (e) {
      Get.snackbar('Error Login Account', e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }

  SaveUserToFireStore(UserCredential user) async {
    UserModel userModel = UserModel(
        userId: user.user.uid,
        email: user.user.email,
        name: user.user.displayName ?? name,
        pic: user.user.photoURL ?? "");
    await FireStoreUser().AddUserToFireStore(userModel);
    _getCurrentUser(user.user.uid);
  }

  saveUserDataTosharedPreference(UserModel userModel) async {
    local_StorageUserData.setUser(userModel);
  }

  void _getCurrentUser(String uid) async {
    await FireStoreUser().getCurrentUser(uid).then((value) {
      //  print(value.data());
      saveUserDataTosharedPreference(UserModel.fromjson(value.data()));
    });
  }
}
