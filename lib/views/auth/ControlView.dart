import 'package:e_commerce_app/Constant.dart';
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
      builder: (homeViewController) => DefaultTabController(
        length: 3,
        initialIndex: homeViewController.navigatorvalue,
        child: GetBuilder<CartController>(
          init: Get.find(),
          builder: (cartController) => Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      for (final key in _kPages.keys)
                        // old method if key goto page
                        //ToDo:
                        key == "home"
                            ? HomeView()
                            : key == "cart"
                                ? CartView()
                                : ProfileView()

                      // HomeView(),
                      // CartView(),
                      // ProfileView(),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: ConvexAppBar.badge(
              // Optional badge argument: keys are tab indices, values can be
              // String, IconData, Color or Widget.

              /*badge=*/ <int, dynamic>{
                1: cartController.cartproductList.length.toString()
              },
              style: TabStyle.reactCircle,
              items: <TabItem>[
                for (final entry in _kPages.entries)
                  TabItem(icon: Icon(entry.value), title: entry.key)
              ],
              onTap: (index) {
                homeViewController.changeSelectedValue(index);
                print(homeViewController.navigatorvalue);
              },
              backgroundColor: primarycolor,
            ),
          ),
        ),
      ),
    );
  }
}
