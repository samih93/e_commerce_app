// @dart=2.9

import 'package:e_commerce_app/helper/homeviewbinding.dart';
import 'package:e_commerce_app/helper/localStorageUserData.dart';
import 'package:e_commerce_app/models/UserModel.dart';
import 'package:e_commerce_app/service/FireStoreUser.dart';
import 'package:e_commerce_app/views/auth/ControlView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  bool _isloading = false;
  bool get isloading => _isloading;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  // static final FacebookLogin facebookSignIn = new FacebookLogin();
  final fb = FacebookLogin();

  String email = "", password = "", name = "";
  bool _showpassword = true;
  bool get showpassword => _showpassword;

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

  void onchangepasswordvisibility() {
    _showpassword = !_showpassword;
    update();
  }

  void googleSignInMethod() async {
    _isloading = true;
    // sign in with google
    final GoogleSignInAccount googleuser = await _googleSignIn.signIn();

    // save google email after signin in firebase
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleuser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    await _auth.signInWithCredential(credential).then((usercredential) {
      UserModel userModel = UserModel(
          email: usercredential.user.email,
          name: usercredential.user.displayName,
          pic: usercredential.user.photoURL,
          userId: usercredential.user.uid);

      SaveUserToFireStore(userModel);
      _isloading = false;
      update();
    });
    Get.offAll(() => ControlView(), binding: HomeViewBinding());
  }

  void facebookSignInMethod() async {
    // final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    // final accessToken = result.accessToken.token;
    // if (result.status == FacebookLoginStatus.loggedIn) {
    //   final facebookcredential = FacebookAuthProvider.credential(accessToken);
    //   await _auth.signInWithCredential(facebookcredential).then((user) {
    //     SaveUserToFireStore(user);
    //   });
    //   Get.offAll(() => ControlView(), binding: HomeViewBinding());
    // }

    // Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

// Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in
        // Send access token to server for validation and auth
        final FacebookAccessToken accessToken = res.accessToken;
        print('Access token: ${accessToken.token}');

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile.name}! You ID: ${profile.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');

        final facebookcredential =
            FacebookAuthProvider.credential(accessToken.token);
        await _auth.signInWithCredential(facebookcredential).then((value) {
          UserModel user = UserModel(
              email: value.user.email,
              name: profile.firstName + " " + profile.lastName,
              pic: imageUrl,
              userId: value.user.uid);
          SaveUserToFireStore(user);
        });

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }

  bool isloadingSignIn = false;

  void SignInWithEmailAndPassword() async {
    isloadingSignIn = true;
    update();
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        isloadingSignIn = false;
        update();

        _getCurrentUser(user.user.uid);
      }); // .then((value) => print(value));
      Get.offAll(() => ControlView(), binding: HomeViewBinding());
    } catch (e) {
      Get.snackbar('Error Login Account', e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }

  bool isloadingCreateAccount = false;
  void CreateAccount() async {
    isloadingCreateAccount = true;
    update();
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredential) {
        UserModel user = UserModel(
            email: email, name: name, pic: '', userId: userCredential.user.uid);
        isloadingCreateAccount = false;
        update();
        SaveUserToFireStore(user);
      }); // .then((value) => print(value));
      Get.offAll(() => ControlView(), binding: HomeViewBinding());
    } catch (e) {
      Get.snackbar('Error Login Account', e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }

  SaveUserToFireStore(UserModel user) async {
    // UserModel userModel = UserModel(
    //     userId: user.user.uid,
    //     email: user.user.email,
    //     name: user.user.displayName ?? name,
    //     pic: user.user.photoURL ?? "");
    await FireStoreUser().AddUserToFireStore(user);
    _getCurrentUser(user.userId);
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

  Future resetpasword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
