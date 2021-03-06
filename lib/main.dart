import 'package:e_commerce_app/Controller/AuthController.dart';
import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/Controller/ShippingController.dart';
import 'package:e_commerce_app/Controller/layoutcontroller.dart';
import 'package:e_commerce_app/Controller/ordercontroller.dart';
import 'package:e_commerce_app/Controller/payment_controller.dart';
import 'package:e_commerce_app/helper/Binding.dart';
import 'package:e_commerce_app/helper/localStorageUserData.dart';
import 'package:e_commerce_app/layout/layout.dart';
import 'package:e_commerce_app/service/HomeViewModelService.dart';
import 'package:e_commerce_app/service/sqflitedatabase/EcommerceDatabasehelper.dart';
import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await EcommerceDatabasehelper.db.initDb();
  await LocalStorageUserData.Init();

  Widget widget;

  currentuserModel = await LocalStorageUserData.getuserData();

  if (currentuserModel != null) {
    print("current user " + currentuserModel!.name.toString());
    Get.put(HomeViewModelService());

    widget = EcommerceLayout();
  } else {
    print("current user null");

    widget = LoginView();
  }

  Get.put(CartController());
  Get.put(OrderController());
  Get.put(ShippingController());
  Get.put(PaymentController());
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;
  MyApp(this.widget);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // bind the dependency
      initialBinding: Binding(),
      home: Scaffold(
        body: widget,
      ),
    );
  }
}
