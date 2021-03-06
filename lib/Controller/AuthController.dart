import 'package:e_commerce_app/helper/homeviewbinding.dart';
import 'package:e_commerce_app/helper/localStorageUserData.dart';
import 'package:e_commerce_app/layout/layout.dart';
import 'package:e_commerce_app/models/UserModel.dart';
import 'package:e_commerce_app/service/FireStoreUser.dart';
import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  // static final FacebookLogin facebookSignIn = new FacebookLogin();
  final fb = FacebookLogin();

  String email = "", password = "", name = "";
  bool _showpassword = true;
  bool get showpassword => _showpassword;

  GoogleSignInAccount? _googleuser;

  String errorMessage = "";
  //ToDo:
  // final _user = Rx<User>();
  // String get user => _user.value?.email;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // any change in _auth bind the result to _user
    // _user.bindStream(_auth.authStateChanges());
    // if (_auth.currentUser != null) {
    //   _getCurrentUser(_auth.currentUser.uid);
    // }
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

  bool _isloadingsigninwithgoogle = false;
  bool get isloadingsigninwithgoogle => _isloadingsigninwithgoogle;
  Future<UserModel?> googleSignInMethod() async {
    UserModel? userModel;
    _isloadingsigninwithgoogle = true;
    // sign in with google

    await _googleSignIn.signIn().then((value) async {
      GoogleSignInAuthentication googleSignInAuthentication =
          await value!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      await _auth.signInWithCredential(credential).then((usercredential) {
        userModel = UserModel(
            email: usercredential.user?.email,
            name: usercredential.user?.displayName,
            pic: usercredential.user?.photoURL,
            userId: usercredential.user?.uid);
        _isloadingsigninwithgoogle = false;
        update();
        SaveUserToFireStore(userModel!);
      });
    }).catchError((error) {
      _isloadingsigninwithgoogle = false;
      errorMessage = error.toString();
      update();
    });

    return userModel;
  }

  bool _isloadingsigninwithfacebook = false;
  bool get isloadingsigninwithfacebook => _isloadingsigninwithfacebook;

  Future<UserModel?> facebookSignInMethod() async {
    UserModel? userModel;

    _isloadingsigninwithfacebook = true;
    update();
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
        final FacebookAccessToken? accessToken = res.accessToken;
        print('Access token: ${accessToken?.token}');

        // Get profile data
        final profile = await fb.getUserProfile();
        print('Hello, ${profile?.name}! You ID: ${profile?.userId}');

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');

        final facebookcredential =
            FacebookAuthProvider.credential(accessToken!.token);
        await _auth.signInWithCredential(facebookcredential).then((value) {
          userModel = UserModel(
              email: value.user?.email,
              name: profile!.firstName.toString() +
                  " " +
                  profile.lastName.toString(),
              pic: imageUrl,
              userId: value.user?.uid);
          _isloadingsigninwithfacebook = false;
          update();
          SaveUserToFireStore(userModel!);
        });

        break;
      case FacebookLoginStatus.cancel:
        errorMessage = "canceled";
        _isloadingsigninwithfacebook = false;
        update();
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        errorMessage = res.error.toString();
        _isloadingsigninwithfacebook = false;
        update();

        break;
    }
    return userModel;
  }

  bool isloadingSignIn = false;

  Future<UserModel?> SignInWithEmailAndPassword() async {
    UserModel? userModel;
    isloadingSignIn = true;
    update();
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        userModel = UserModel(
            email: value.user?.email,
            name: value.user?.displayName,
            pic: '',
            userId: value.user?.uid);
        isloadingSignIn = false;
        update();

        // _getCurrentUser(user.user.uid);
      }); // .then((value) => print(value));
      //Get.offAll(() => EcommerceLayout(), binding: HomeViewBinding());
    } catch (e) {
      isloadingSignIn = false;

      errorMessage = e.toString();
      update();
      print(e.toString());
    }
    return userModel;
  }

  bool isloadingCreateAccount = false;
  Future<UserModel?> CreateAccount() async {
    UserModel? userModel;
    isloadingCreateAccount = true;
    update();
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredential) {
        userModel = UserModel(
            email: email,
            name: name,
            pic: '',
            userId: userCredential.user?.uid);
        isloadingCreateAccount = false;
        update();
        SaveUserToFireStore(userModel!);
      }); // .then((value) => print(value));
      // Get.offAll(() => EcommerceLayout(), binding: HomeViewBinding());
    } catch (e) {
      errorMessage = e.toString();
      isloadingCreateAccount = false;
      update();
    }
    return userModel;
  }

  SaveUserToFireStore(UserModel user) async {
    // UserModel userModel = UserModel(
    //     userId: user.user.uid,
    //     email: user.user.email,
    //     name: user.user.displayName ?? name,
    //     pic: user.user.photoURL ?? "");
    await FireStoreUser().AddUserToFireStore(user);
    // _getCurrentUser(user.userId);
  }

  // saveUserDataTosharedPreference(UserModel userModel) async {
  //   local_StorageUserData.setUser(userModel);
  // }

  // void _getCurrentUser(String uid) async {
  //   await FireStoreUser().getCurrentUser(uid).then((value) {
  //     //  print(value.data());
  //     saveUserDataTosharedPreference(UserModel.fromjson(value.data()));
  //   });
  // }

  Future resetpasword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  void saveuserThenNavigate(UserModel userModel) {
    currentuserModel = userModel;
    LocalStorageUserData.setUser(userModel);
    Get.off(
      () => EcommerceLayout(),
      binding: HomeViewBinding(),
    );
  }

  SignOut() async {
    GoogleSignIn().signOut();
    FacebookLogin().logOut();
    await FirebaseAuth.instance.signOut();
    await LocalStorageUserData.deleteUser();
    Get.offAll(LoginView());
  }
}
