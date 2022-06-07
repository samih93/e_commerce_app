import 'package:e_commerce_app/Controller/AuthController.dart';
import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/Controller/ShippingController.dart';
import 'package:e_commerce_app/Controller/layoutcontroller.dart';
import 'package:e_commerce_app/Controller/ordercontroller.dart';
import 'package:e_commerce_app/Controller/payment_controller.dart';
import 'package:e_commerce_app/service/HomeViewModelService.dart';
import 'package:e_commerce_app/helper/localStorageUserData.dart';
import 'package:e_commerce_app/views/ShippingAddressView.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthController());
    //Get.lazyPut(() => HomeViewModelService());
    Get.lazyPut(() => OrderController());
    Get.put(() => LayoutController(), permanent: true);
    //Get.lazyPut(() => ProfileController());
  }
}
