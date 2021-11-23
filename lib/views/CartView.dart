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
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CartController>(
              init: Get.find(),
              builder: (cartcontroller) => Container(
                child: ListView.separated(
                  itemCount: cartcontroller.cardproductList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 120,
                      child: Row(
                        children: [
                          cartcontroller.cardproductList[index].image != ""
                              ? Image.network(
                                  cartcontroller.cardproductList[index].image)
                              : Image.asset("assets/icons/chaire.png"),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartcontroller.cardproductList[index].name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomText(
                                  text: "\$ " +
                                      cartcontroller
                                          .cardproductList[index].price,
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
                                        padding: EdgeInsets.only(bottom: 20),
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
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                ),
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
                      text: "\$ 300",
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
    );
  }
}
