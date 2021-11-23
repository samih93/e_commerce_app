// @dart=2.9

import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/Controller/HomeController.dart';
import 'package:e_commerce_app/models/CartProduct.dart';
import 'package:e_commerce_app/models/Product.dart';
import 'package:e_commerce_app/service/sqflitedatabase/CartDatabasehelper.dart';
import 'package:e_commerce_app/views/auth/ControlView.dart';
import 'package:e_commerce_app/views/home_view.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsProduct extends StatelessWidget {
  Product product;
  List<int> listOfsizeNumbers = <int>[40, 41, 42, 43, 44, 45];
  DetailsProduct({this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Get.to(ControlView()) //Get.off(page),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              width: MediaQuery.of(context).size.width * .44,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomText(text: "Size"),
                                  CustomText(
                                    text: product.size,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              width: MediaQuery.of(context).size.width * .44,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomText(text: "Color"),
                                  Container(
                                    width: 30,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: product.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // _productsizes(),
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
                          onPress: () {
                            CartController.addProduct(CartProduct(
                                name: product.name,
                                image: product.image,
                                price: product.price,
                                quantity: 1));
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

//   Widget _productsizes() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           width: 42,
//           height: 38,
//           child: GestureDetector(
//             onTap: () {
//               print(listOfsizeNumbers[0].toString());
//             },
//             child: CustomText(text: listOfsizeNumbers[0].toString()),
//           ),
//         ),
//       ],
//     );
//   }
}
