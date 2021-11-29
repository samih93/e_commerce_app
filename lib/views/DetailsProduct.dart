// @dart=2.9

import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/Controller/HomeController.dart';
import 'package:e_commerce_app/models/CartProduct.dart';
import 'package:e_commerce_app/models/Product.dart';
import 'package:e_commerce_app/service/sqflitedatabase/EcommerceDatabasehelper.dart';
import 'package:e_commerce_app/views/CartView.dart';
import 'package:e_commerce_app/views/auth/ControlView.dart';
import 'package:e_commerce_app/views/home_view.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';

class DetailsProduct extends StatelessWidget {
  Product product;
  DetailsProduct({this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            GetBuilder<CartController>(
              init: Get.find(),
              builder: (cartController) => Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => CartView()),
                    child: FlutterBadge(
                      icon: Image.asset(
                        "assets/icons/Icon_Cart.png",
                        fit: BoxFit.fill,
                      ),
                      itemCount: cartController.cartproductList != null
                          ? cartController.cartproductList.length ?? 0
                          : 0,
                      hideZeroCount: false,
                      badgeColor: primarycolor,
                      borderRadius: 20.0,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () => Get.off(() => ControlView()),
                      child: Icon(
                        Icons.home,
                        color: primarycolor,
                        size: 30,
                      )),
                ],
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Get.off(ControlView()) //Get.off(page),
              ),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 270,
                child: Image.network(
                  product.image,
                  fit: BoxFit.fill,
                ),
                // width: MediaQuery.of(context).size.width,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        CustomText(
                          text: product.name,
                          fontSize: 25,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15, bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: GetBuilder<CartController>(
                            init: Get.find(),
                            builder: (cartcontroller) => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Size",
                                  alignment: Alignment.centerLeft,
                                  fontSize: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CustomText(
                                  text: cartcontroller.selectedSize,
                                  color: Colors.grey,
                                )
                                // CustomText(
                                //   text: product.size,
                                // ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        _productsizes(product.sizes),
                        SizedBox(
                          height: 30,
                        ),
                        CustomText(
                          text: "Details",
                          fontSize: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomText(
                          text: product.description,
                          maxLine: 10,
                          fontSize: 20,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          CustomText(text: "Price", color: Colors.grey[400]),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            text: "${product.price} \$",
                            fontSize: 20,
                            color: primarycolor,
                          )
                        ],
                      ),
                    ),
                    GetBuilder<CartController>(
                      init: Get.find(),
                      builder: (CartController) => Container(
                        width: 150,
                        child: CustomButton(
                          text: "Add",
                          onPress: () async {
                            print(product.id);
                            if (CartController.selectedSize != "") {
                              bool isAdded = await CartController.addProduct(
                                  CartProduct(
                                      productId: product.id,
                                      name: product.name,
                                      image: product.image,
                                      price: product.price,
                                      size: CartController.selectedSize,
                                      color: product.color,
                                      description: product.description,
                                      quantity: 1));
                              if (!isAdded) {
                                _onAlertWithCustomImagePressed(context);
                                // reset selected size to nothing if on click on product
                                CartController.onInitializeSize();
                              } else {
                                Toast.show("Already Added", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.CENTER);
                                CartController.onInitializeSize();
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: primarycolor,
                                    content:
                                        Text("Select size befor add to cart")),
                              );
                              return false;
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  _onAlertWithCustomImagePressed(context) {
    var alertStyle = AlertStyle(animationDuration: Duration(milliseconds: 1));
    Alert(
      style: alertStyle,
      context: context,
      title: "Item Added to Cart",
      image: Image.asset("assets/images/success.png"),
      buttons: [
        DialogButton(
          child: Text(
            "Go To Cart",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Get.off(CartView()),
          width: 120,
        )
      ],
    ).show();
  }

  Widget _productsizes(List<String> sizes) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: List.generate(
          sizes.length,
          (index) => GetBuilder<CartController>(
            init: Get.find(),
            builder: (cartController) => GestureDetector(
              onTap: () => cartController.onselectsize(sizes[index].toString()),
              child: Container(
                margin: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    sizes[index],
                    style: TextStyle(fontSize: 5),
                  ),
                ),
                width: 34,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300,
                  border: cartController.selectedSize == sizes[index]
                      ? Border.all(color: primarycolor, width: 2)
                      : Border.all(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
