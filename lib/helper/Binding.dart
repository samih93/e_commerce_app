import 'package:e_commerce_app/viewmodel/AuthViewModel.dart';
import 'package:e_commerce_app/viewmodel/HomeViewModel.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => HomeViewModel());
  }
}
