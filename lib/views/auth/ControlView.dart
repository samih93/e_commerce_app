import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/Controller/AuthController.dart';
import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/Controller/HomeController.dart';
import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:get/get.dart';

class ControlView extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthController>().user == null)
          ? LoginView()
          : GetBuilder<HomeController>(
              init: HomeController(),
              builder: (HomeViewController) => Scaffold(
                body: HomeViewController.currentscreen,
                bottomNavigationBar: _bottomNavigationbar(),
              ),
            );
    });
  }

  Widget _bottomNavigationbar() {
    return GetBuilder<HomeController>(
      init: Get.find(),
      builder: (HomeViewController) => BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: CustomText(
                text: "Explore",
                fontSize: 20,
                color: primarycolor,
                alignment: Alignment.center,
              ),
            ),
            label: "",
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                "assets/icons/Icon_Explore.png",
                fit: BoxFit.fill,
                width: 20,
              ),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: CustomText(
                text: "Card",
                fontSize: 20,
                color: primarycolor,
                alignment: Alignment.center,
              ),
            ),
            label: "",
            icon: GetBuilder<CartController>(
              init: Get.find(),
              builder: (cartController) => FlutterBadge(
                icon: Image.asset(
                  "assets/icons/Icon_Cart.png",
                  fit: BoxFit.fill,
                ),
                itemCount: cartController.cardproductList != null
                    ? cartController.cardproductList.length ?? 0
                    : 0,
                hideZeroCount: false,
                badgeColor: primarycolor,
                borderRadius: 20.0,
              ),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: CustomText(
                alignment: Alignment.center,
                text: "Account",
                fontSize: 20,
                color: primarycolor,
              ),
            ),
            label: "",
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                "assets/icons/Icon_User.png",
                fit: BoxFit.fill,
                width: 20,
              ),
            ),
          ),
        ],
        currentIndex: HomeViewController.navigatorvalue,
        onTap: (index) {
          HomeViewController.changeSelectedValue(index);
          print(HomeViewController.navigatorvalue);
        },
        elevation: 0,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.grey.shade50,
      ),
    );
  }
}
