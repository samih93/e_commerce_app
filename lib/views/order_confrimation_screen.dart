import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/Controller/payment_controller.dart';
import 'package:e_commerce_app/models/payment_model.dart';
import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/shared/style.dart';
import 'package:e_commerce_app/views/ShippingAddressView.dart';
import 'package:e_commerce_app/views/credit_card/payment_method_screen.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class OrderConfirmationScreen extends StatelessWidget {
  OrderConfirmationScreen({Key key}) : super(key: key);

  var controller = Get.put(PaymentController());
  var cartcontroller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          "Order Confirmation",
        ),
        backgroundColor: primarycolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _personalinformation(),
                  SizedBox(
                    height: 10,
                  ),
                  _visaCardSection(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cartcontroller.cartproductList.length,
                      itemBuilder: (context, index) => _checkoutItems(index),
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                    ),
                  ),
                ],
              ),
            ),
            _bottomPaySection(),
          ],
        ),
      ),
    );
  }

  _personalinformation() => GestureDetector(
        onTap: () {
          Get.to(ShippingAddressScreen());
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Samih damaj",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "961718233",
                      style: greyColor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("sebline , Mount Lebanon , LB ,1504")
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      );

  _visaCardSection() => GestureDetector(
        onTap: () async {
          PaymentModel model = await controller.getPaymentMethod();
          Get.to(PaymentMethodScreen(model));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(
                Icons.payment_outlined,
                size: 30,
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                  height: 35, child: Image.asset("assets/mastercard.png")),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  "3334*******3923",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      );

  _checkoutItems(int index) => Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            height: 130,
            width: 130,
            child: cartcontroller.cartproductList[index].image != ""
                ? Image.network(
                    cartcontroller.cartproductList[index].image,
                    fit: BoxFit.fitWidth,
                  )
                : Image.asset("assets/icons/chaire.png"),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 15, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartcontroller.cartproductList[index].name,
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
                  GetBuilder<CartController>(
                    init: Get.find<CartController>(),
                    builder: (cart_contro) => CustomText(
                      text: "\$ " + cart_contro.cartproductList[index].price,
                      color: primarycolor,
                    ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            cartcontroller.increase_decrease_quatity(
                                index, true);
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                        GetBuilder<CartController>(
                          init: Get.find<CartController>(),
                          builder: (cart_contro) => CustomText(
                            text: cartcontroller.cartproductList[index].quantity
                                .toString(),
                            alignment: Alignment.center,
                            fontSize: 25,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            cartcontroller.increase_decrease_quatity(
                                index, false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
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
          ),
        ],
      ));

  _bottomPaySection() => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Total",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                GetBuilder<CartController>(
                  init: Get.find(),
                  builder: (cart_controller) => CustomText(
                    text: "\$  ${cart_controller.totalprice}",
                    fontSize: 20,
                    color: primarycolor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            CustomButton(
              text: "PAY NOW",
              onPress: () {},
            ),
          ]),
        ),
      );
}
