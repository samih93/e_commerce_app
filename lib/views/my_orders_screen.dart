import 'package:e_commerce_app/Controller/ordercontroller.dart';
import 'package:e_commerce_app/models/CartProduct.dart';
import 'package:e_commerce_app/models/Product.dart';
import 'package:e_commerce_app/models/ordermodel.dart';
import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/shared/style.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class MyOrdersScreen extends StatelessWidget {
  MyOrdersScreen({Key? key}) : super(key: key);
  BuildContext? _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: primarycolor,
        title: Text("My Orders"),
      ),
      body: GetBuilder<OrderController>(
        init: Get.find<OrderController>(),
        builder: (orderController) => SingleChildScrollView(
          child: Column(children: [
            ...orderController.myOrders.map((e) => Column(
                  children: [
                    Container(
                      child: _buildMyOrders(e),
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                )),
          ]),
        ),
      ),
    );
  }

  _buildMyOrders(Order order) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Order ID: ",
                style: greyColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text("${order.orderId}"),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "Order Time: ",
                style: greyColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text("${order.orderdate!.toDate().toString().split('.').first}"),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "Status: ",
                style: greyColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text("${order.status}"),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ...order.orderItems!.map((cart) => _buildItem(cart)),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: greyColor,
              ),
              CustomText(
                text: "\$ " + "${order.totalprice}",
                color: primarycolor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildItem(CartProduct cart) => Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 120),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(_context!).size.width * .3,
                    child: cart.image != ""
                        ? Image.network(
                            cart.image.toString(),
                            fit: BoxFit.cover,
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
                            "${cart.name.toString()}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(text: "Size : ${cart.size.toString()}"),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            text: "\$ " +
                                "${cart.price.toString()} * ${cart.quantity.toString()}",
                            color: primarycolor,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Qty",
                style: greyColor,
              ),
              Text("${cart.quantity}"),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Amount",
                style: greyColor,
              ),
              CustomText(
                text: "\$ " +
                    "${int.parse(cart.price.toString()) * int.parse(cart.quantity.toString())}",
                color: primarycolor,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          CustomButton(
            onPress: () {},
            text: "Tracking",
            color: primarycolor.shade300,
          ),
          SizedBox(
            height: 15,
          ),
          CustomButton(onPress: () {}, text: "Confirm Order Received"),
          SizedBox(
            height: 15,
          ),
        ],
      );
}
