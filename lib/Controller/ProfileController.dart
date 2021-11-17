import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  SignOut() async {
    await _auth.signOut();
    Get.off(LoginView());
  }
}
