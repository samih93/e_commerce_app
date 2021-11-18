import 'package:e_commerce_app/Controller/AuthController.dart';
import 'package:e_commerce_app/Controller/HomeController.dart';
import 'package:e_commerce_app/service/HomeViewModelService.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => HomeViewModelService());
  }
}
