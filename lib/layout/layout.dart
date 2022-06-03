import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/Controller/layoutcontroller.dart';
import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/views/CartView.dart';
import 'package:e_commerce_app/views/ProfileView.dart';
import 'package:e_commerce_app/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EcommerceLayout extends StatelessWidget {
  var _kPages = <String, IconData>{
    'home': Icons.home,
    'cart': Icons.shopping_bag,
    'account': Icons.person,
  };
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutController>(
        init: LayoutController(),
        builder: (layoutController) {
          return Scaffold(
            body: layoutController.currentscreen,
            bottomNavigationBar: _bottomNavigationbar(),
          );
        });
  }

  Widget _bottomNavigationbar() {
    return GetBuilder<LayoutController>(
      init: Get.find(),
      builder: (controller) => DefaultTabController(
        length: 3,
        initialIndex: controller.navigatorvalue,
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
                controller.changeSelectedValue(index);
                print(controller.navigatorvalue);
              },
              backgroundColor: primarycolor,
            ),
          ),
        ),
      ),
    );
  }
}
