import 'package:e_commerce_app/Controller/AuthController.dart';
import 'package:e_commerce_app/Controller/payment_controller.dart';
import 'package:e_commerce_app/service/HomeViewModelService.dart';
import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/views/ShippingAddressView.dart';
import 'package:e_commerce_app/views/credit_card/payment_method_screen.dart';
import 'package:e_commerce_app/views/my_orders.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
//import 'package:flutter_badged/flutter_badge.dart';
import 'package:get/get.dart';

import 'WishList.dart';

class ProfileView extends StatelessWidget {
  var controller = Get.put(PaymentController());
  var authcontroller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Container(
          child: Column(
            //ToDo:
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: primarygradient),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 15),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,

                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: currentuserModel != null &&
                                    currentuserModel.pic.toString().trim() != ""
                                ? NetworkImage(currentuserModel.pic)
                                : AssetImage(
                                    "assets/images/default profile.png",
                                  ),
                            fit: BoxFit.fill),
                        //whatever image you can put here
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomText(
                      text: currentuserModel != null
                          ? currentuserModel.name ?? ""
                          : "",
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: currentuserModel != null
                          ? currentuserModel.email ?? ""
                          : "",
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                      title: Text("Profile"),
                      leading: Icon(Icons.account_box),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () {},
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                    ListTile(
                        title: Text("Shipping Address"),
                        leading: Icon(Icons.location_on_outlined),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () => Get.to(ShippingAddressScreen())),
                    Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                    ListTile(
                      title: Text("Orders"),
                      leading: Icon(Icons.list),
                      trailing: FlutterBadge(
                        icon: Icon(
                          Icons.message,
                          size: 30,
                        ),
                        itemCount: 0,
                        hideZeroCount: false,
                        badgeColor: primarycolor,
                        borderRadius: 20.0,
                      ),
                      onTap: () {
                        Get.to(MyOrdersScreen());
                      },
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                    GetBuilder<HomeViewModelService>(
                      init: Get.find(),
                      builder: (homeViewModelService) => ListTile(
                        title: Text("Wish List"),
                        leading: Icon(Icons.favorite_border),
                        trailing: FlutterBadge(
                          icon: Icon(
                            Icons.favorite_outlined,
                            size: 30,
                          ),
                          itemCount: homeViewModelService.favoriteproduct !=
                                  null
                              ? homeViewModelService.favoriteproduct.length ?? 0
                              : 0,
                          hideZeroCount: false,
                          badgeColor: primarycolor,
                          borderRadius: 20.0,
                        ),
                        onTap: () {
                          Get.to(
                              WishList()); // homeViewModelService.favoriteproduct
                        },
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                    ListTile(
                      title: Text("Payment Method"),
                      leading: Icon(Icons.payment),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () async {
                        await controller.getPaymentMethod();
                        Get.to(PaymentMethodScreen());
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: CustomButton(
                  text: "Sign Out",
                  onPress: () => authcontroller.SignOut(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
