import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CartController>(
        init: Get.find(),
        builder: (cartcontroller) => cartcontroller.loading == true
            ? Center(child: CircularProgressIndicator())
            : cartcontroller.cardproductList.length == 0
                ? Center(
                    child: CustomText(
                    alignment: Alignment.center,
                    text: "Your Cart Is Empty",
                    fontSize: 22,
                  ))
                : Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: ListView.separated(
                            itemCount: cartcontroller.cardproductList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 120,
                                child: Row(
                                  children: [
                                    cartcontroller
                                                .cardproductList[index].image !=
                                            ""
                                        ? Image.network(cartcontroller
                                            .cardproductList[index].image)
                                        : Image.asset(
                                            "assets/icons/chaire.png"),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartcontroller
                                                .cardproductList[index].name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CustomText(
                                            text: "\$ " +
                                                cartcontroller
                                                    .cardproductList[index]
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
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                  color: Colors.black,
                                                ),
                                                CustomText(
                                                  text: "1",
                                                  alignment: Alignment.center,
                                                  fontSize: 25,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 20),
                                                  child: Icon(
                                                    Icons.minimize,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                        child: Container(
                                          child: Icon(
                                            Icons.delete,
                                            color: primarycolor,
                                          ),
                                        ),
                                        onTap: () {
                                          cartcontroller
                                              .deleteproductfromdatbase(
                                                  cartcontroller
                                                      .cardproductList[index]
                                                      .productId);
                                        }),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
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
                              onPress: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
