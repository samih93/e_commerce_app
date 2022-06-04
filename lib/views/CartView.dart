import 'package:e_commerce_app/Controller/ShippingController.dart';
import 'package:e_commerce_app/Controller/payment_controller.dart';
import 'package:e_commerce_app/layout/layout.dart';
import 'package:e_commerce_app/models/Address.dart';
import 'package:e_commerce_app/models/payment_model.dart';
import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/models/Product.dart';
import 'package:e_commerce_app/views/DetailsProduct.dart';
import 'package:e_commerce_app/views/order_confrimation_screen.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CartView extends StatelessWidget {
  var shippingAddressController = Get.find<ShippingController>();
  var paymentMethodController = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: Get.find(),
      builder: (cartcontroller) => cartcontroller.loading == true
          ? Center(child: CircularProgressIndicator())
          : cartcontroller.cartproductList.length == 0
              ? Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/emty card.svg",
                        alignment: Alignment.center,
                        width: 200,
                        height: 240,
                      ),
                      SizedBox(height: 15),
                      CustomText(
                        text: "Cart Is Empty",
                        fontSize: 25,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                )
              : Scaffold(
                  backgroundColor: Colors.white,
                  body: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 35, left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text:
                                    "Cart ( ${cartcontroller.cartproductList.length} )",
                                fontSize: 30,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () => Get.off(() => EcommerceLayout()),
                                      child: Icon(
                                        Icons.home,
                                        color: Colors.black,
                                        size: 25,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      var alertStyle = AlertStyle(
                                          animationDuration:
                                              Duration(milliseconds: 1));
                                      Alert(
                                        style: alertStyle,
                                        context: context,
                                        type: AlertType.error,
                                        title: "Delete All Items",
                                        desc:
                                            "Are You Sure You Want To Delete All Items.",
                                        buttons: [
                                          DialogButton(
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            color: Colors.blue.shade400,
                                          ),
                                          DialogButton(
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            onPressed: () async {
                                              await cartcontroller
                                                  .deleteAllcartItems();
                                              Navigator.pop(context);
                                            },
                                            color: Colors.red.shade400,
                                          ),
                                        ],
                                      ).show();
                                    },
                                    child: Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 8, right: 8, top: 20),
                            child: ListView.separated(
                              itemCount: cartcontroller.cartproductList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    //TODo:
                                    // Get.off(DetailsProduct(
                                    //   product: Product(
                                    //       id: cartcontroller
                                    //           .cardproductList[index].productId,
                                    //       name: cartcontroller
                                    //           .cardproductList[index].name,
                                    //       image: cartcontroller
                                    //           .cardproductList[index].image,
                                    //       description: cartcontroller
                                    //           .cardproductList[index].description,
                                    //       color: cartcontroller
                                    //           .cardproductList[index].color,
                                    //       sizes: [],
                                    //       //     cartcontroller.listOfSizesOfproduct,
                                    //       price: cartcontroller
                                    //           .cardproductList[index].price),
                                    // ));
                                  },
                                  child: Container(
                                    height: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(blurRadius: 10),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .1,
                                          padding: EdgeInsets.all(8),
                                          child: Checkbox(
                                              value: cartcontroller
                                                  .cartproductList[index]
                                                  .ischecked,
                                              onChanged: (bool value) {
                                                cartcontroller.onchangeCheckbox(
                                                    index, value);
                                              }), // This is where we update the state when the checkbox is tapped
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .3,
                                          child: cartcontroller
                                                      .cartproductList[index]
                                                      .image !=
                                                  ""
                                              ? Image.network(
                                                  cartcontroller
                                                      .cartproductList[index]
                                                      .image,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  "assets/icons/chaire.png"),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .44,
                                          padding: EdgeInsets.only(
                                              top: 15, left: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cartcontroller
                                                    .cartproductList[index]
                                                    .name,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              CustomText(
                                                  text:
                                                      "Size : ${cartcontroller.cartproductList[index].size}"),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              CustomText(
                                                text: "\$ " +
                                                    cartcontroller
                                                        .cartproductList[index]
                                                        .price,
                                                color: primarycolor,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                width: 120,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade300,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartcontroller
                                                            .increase_decrease_quatity(
                                                                index, true);
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    CustomText(
                                                      text: cartcontroller
                                                          .cartproductList[
                                                              index]
                                                          .quantity
                                                          .toString(),
                                                      alignment:
                                                          Alignment.center,
                                                      fontSize: 25,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartcontroller
                                                            .increase_decrease_quatity(
                                                                index, false);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 5.0),
                                                        child: Icon(
                                                          Icons.minimize,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: 10,
                                        // ),
                                        Expanded(
                                          flex: 1,
                                          child: GestureDetector(
                                              child: Container(
                                                child: Icon(
                                                  Icons.delete,
                                                  color: primarycolor,
                                                ),
                                              ),
                                              onTap: () {
                                                var alertStyle = AlertStyle(
                                                    animationDuration: Duration(
                                                        milliseconds: 1));
                                                Alert(
                                                  style: alertStyle,
                                                  context: context,
                                                  type: AlertType.error,
                                                  title: "Delete Item",
                                                  desc:
                                                      "Are You Sure You Want To Delete This Item.",
                                                  buttons: [
                                                    DialogButton(
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      color:
                                                          Colors.blue.shade400,
                                                    ),
                                                    DialogButton(
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                      onPressed: () {
                                                        cartcontroller
                                                            .deleteproduct(
                                                                cartcontroller
                                                                    .cartproductList[
                                                                        index]
                                                                    .productId);
                                                        Navigator.pop(context);
                                                      },
                                                      color:
                                                          Colors.red.shade400,
                                                    ),
                                                  ],
                                                ).show();
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => Divider(),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  CustomText(
                                    text: "Total",
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 10),
                                  CustomText(
                                    text: "\$  ${cartcontroller.totalprice}",
                                    fontSize: 20,
                                    color: primarycolor,
                                  ),
                                ],
                              ),
                              CustomButton(
                                text: "Checkout",
                                color:
                                    cartcontroller.cartcheckOutList.length == 0
                                        ? primarycolor.shade200
                                        : primarycolor,
                                onPress: () async {
                                  if (cartcontroller.cartcheckOutList.length !=
                                      0) Get.to(OrderConfirmationScreen());
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
