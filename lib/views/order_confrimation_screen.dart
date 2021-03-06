import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/Controller/ShippingController.dart';
import 'package:e_commerce_app/Controller/layoutcontroller.dart';
import 'package:e_commerce_app/Controller/ordercontroller.dart';
import 'package:e_commerce_app/Controller/payment_controller.dart';
import 'package:e_commerce_app/layout/layout.dart';
import 'package:e_commerce_app/models/Address.dart';
import 'package:e_commerce_app/models/CartProduct.dart';
import 'package:e_commerce_app/models/payment_model.dart';
import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/shared/style.dart';
import 'package:e_commerce_app/views/ProfileView.dart';
import 'package:e_commerce_app/views/ShippingAddressView.dart';
import 'package:e_commerce_app/views/credit_card/payment_method_screen.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OrderConfirmationScreen extends StatelessWidget {
  //Address address;)
  OrderConfirmationScreen({Key? key}) : super(key: key);

  var paymentcontroller = Get.find<PaymentController>();
  var cartcontroller = Get.find<CartController>();
  var shippingController = Get.find<ShippingController>();

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
      body: Column(
        children: [
          Expanded(
            child: Padding(
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
                            itemCount: cartcontroller.cartcheckOutList.length,
                            itemBuilder: (context, index) => _checkoutItems(
                                cartcontroller.cartcheckOutList[index]),
                            separatorBuilder:
                                (BuildContext context, int index) => Divider(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _bottomPaySection(context),
        ],
      ),
    );
  }

  _personalinformation() => GestureDetector(
        onTap: () {
          Get.to(ShippingAddressScreen());
        },
        child: GetBuilder<ShippingController>(
            init: Get.find<ShippingController>(),
            builder: (controller) => Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(14),
                  child: controller.addressmodel != null
                      ? Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${controller.addressmodel!.firstname.toString()} ${controller.addressmodel!.lastname.toString()} , ${controller.addressmodel!.country}-${controller.addressmodel!.phone}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Wrap(
                                      children: [
                                        Text(
                                          "${controller.addressmodel?.location} - ${controller.addressmodel!.city} - ${controller.addressmodel!.state}",
                                          style: greyColor,
                                        ),
                                        Text(
                                          "${controller.addressmodel?.location} - ${controller.addressmodel!.country!.split(")")[0].substring(1)} - ${controller.addressmodel?.postcode}",
                                          style: greyColor,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Enter Shipping Address",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                )),
      );

  _visaCardSection() => GestureDetector(
        onTap: () async {
          // print('model ' + model.toString());
          Get.to(PaymentMethodScreen());
        },
        child: GetBuilder<PaymentController>(
          init: Get.find<PaymentController>(),
          builder: (paymentcontroller) => Container(
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
                  child: paymentcontroller.paymentModel != null
                      ? Text(
                          "${paymentcontroller.paymentModel?.number?.split(' ')[0]}  * * * * * * * * ${paymentcontroller.paymentModel!.number?.split(' ')[3]} ",
                          style: TextStyle(fontWeight: FontWeight.bold))
                      : Text("Select Payment Method"),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      );

  _checkoutItems(CartProduct model) => Container(
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
            child: model.image != ""
                ? Image.network(
                    model.image.toString(),
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
                    model.name.toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(text: "Size : ${model.size}"),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: "\$ " + model.price.toString(),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            cartcontroller.increase_decrease_quatity(
                                model.productId.toString(), true);
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                        GetBuilder<CartController>(
                          init: Get.find<CartController>(),
                          builder: (cart_controller) => CustomText(
                            text: model.quantity.toString(),
                            alignment: Alignment.center,
                            fontSize: 25,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            cartcontroller.increase_decrease_quatity(
                                model.productId.toString(), false);
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

  _bottomPaySection(BuildContext context) => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Total",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                GetBuilder<CartController>(
                  init: Get.find<CartController>(),
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
            GetBuilder<OrderController>(
              init: Get.find<OrderController>(),
              builder: (orderController) => orderController.isloadingPostOrder
                  ? CircularProgressIndicator()
                  : CustomButton(
                      // color: paymentcontroller.paymentModel != null &&
                      //         shippingController.addressmodel != null
                      //     ? null
                      //     : Colors.teal.shade200,
                      text: "PAY NOW",
                      onPress: () async {
                        if (paymentcontroller.paymentModel != null &&
                            shippingController.addressmodel != null) {
                          await orderController
                              .addOrder(
                                  shippingController.addressmodel!,
                                  cartcontroller.cartcheckOutList,
                                  cartcontroller.totalprice)
                              .then((value) {
                            print(value.toString());
                            var alertStyle = AlertStyle(
                                animationDuration: Duration(milliseconds: 1));
                            Alert(
                              style: alertStyle,
                              context: context,
                              title: "ORDER SUCCESSFUL!",
                              image: Image.asset("assets/images/success.png"),
                              content: Text(
                                "ORDER ID '$value'",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              closeFunction: () {},
                              closeIcon: Container(),
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Shop More",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    LayoutController layoutController =
                                        Get.find<LayoutController>();

                                    layoutController.changeSelectedValue(0);
                                    Get.off(EcommerceLayout());
                                    cartcontroller.clearChekoutListFromBasket();
                                  },
                                  width: 120,
                                )
                              ],
                            ).show();
                          });
                        } else {
                          myCustomSnackbar(
                              title: "please fill empty data",
                              body:
                                  "Please fill shipping address and payment method",
                              type: toastType.Error);
                        }
                      },
                    ),
            ),
          ]),
        ),
      );
}
