import 'package:e_commerce_app/Controller/AuthController.dart';
import 'package:e_commerce_app/models/UserModel.dart';
import 'package:e_commerce_app/service/localStorageUserData.dart';
import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getCashedUserModel();
  }

  final AuthController authController = Get.find();

  final localStorageUserData local_StorageUserData = Get.find();

  UserModel get userModel => _userModel;

  UserModel _userModel;

  SignOut() async {
    GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    local_StorageUserData.deleteUser();
    Get.off(LoginView());
  }

  void _getCashedUserModel() async {
    await local_StorageUserData.getuserData.then((value) => _userModel = value);
    update();
  }
}
