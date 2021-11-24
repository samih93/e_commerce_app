import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/models/Product.dart';
import 'package:e_commerce_app/views/DetailsProduct.dart';
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
                          padding: EdgeInsets.all(8),
                          child: ListView.separated(
                            itemCount: cartcontroller.cardproductList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.off(DetailsProduct(
                                    product: Product(
                                        id: cartcontroller
                                            .cardproductList[index].productId,
                                        name: cartcontroller
                                            .cardproductList[index].name,
                                        image: cartcontroller
                                            .cardproductList[index].image,
                                        description: cartcontroller
                                            .cardproductList[index].description,
                                        color: cartcontroller
                                            .cardproductList[index].color,
                                        size: cartcontroller
                                            .cardproductList[index].size,
                                        price: cartcontroller
                                            .cardproductList[index].price),
                                  ));
                                },
                                child: Container(
                                  height: 120,
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .1,
                                        padding: EdgeInsets.all(8),
                                        child: Checkbox(
                                            value: cartcontroller
                                                .cardproductList[index]
                                                .ischecked,
                                            onChanged: (bool value) {
                                              cartcontroller.onchangeCheckbox(
                                                  index, value);
                                            }), // This is where we update the state when the checkbox is tapped
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .3,
                                        child: cartcontroller
                                                    .cardproductList[index]
                                                    .image !=
                                                ""
                                            ? Image.network(cartcontroller
                                                .cardproductList[index].image)
                                            : Image.asset(
                                                "assets/icons/chaire.png"),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .44,
                                        padding:
                                            EdgeInsets.only(top: 15, left: 20),
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
                                                        .cardproductList[index]
                                                        .quantity
                                                        .toString(),
                                                    alignment: Alignment.center,
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
                                                          const EdgeInsets.only(
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
                                              cartcontroller.deleteproduct(
                                                  cartcontroller
                                                      .cardproductList[index]
                                                      .productId);
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
                        color: Colors.grey.shade100,
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
