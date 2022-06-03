import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/Controller/AuthController.dart';
import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/Controller/HomeController.dart';
import 'package:e_commerce_app/views/CartView.dart';
import 'package:e_commerce_app/views/ProfileView.dart';
import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:e_commerce_app/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class ControlView extends GetWidget<AuthController> {
  var _kPages = <String, IconData>{
    'home': Icons.home,
    'cart': Icons.shopping_bag,
    'account': Icons.person,
  };
  @override
  Widget build(BuildContext context) {
    //   return Obx(() {
    //     return (Get.find<AuthController>().user == null)
    //         ? LoginView()
    //         : GetBuilder<HomeController>(
    //             init: HomeController(),
    //             builder: (HomeViewController) => Scaffold(
    //               body: HomeViewController.currentscreen,
    //               bottomNavigationBar: _bottomNavigationbar(),
    //             ),
    //           );
    //   });
    // }
  }
}
