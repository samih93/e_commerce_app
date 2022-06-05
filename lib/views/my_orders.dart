import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/shared/style.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyOrdersScreen extends StatelessWidget {
  MyOrdersScreen({Key key}) : super(key: key);
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarycolor,
        title: Text("My Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _buildMyOrders(),
      ),
    );
  }

  _buildMyOrders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Order ID",
              style: greyColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text("123321312321sadajsd"),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              "Order Time",
              style: greyColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text("2022-05-18 06:55"),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        _buildItem(),
      ],
    );
  }

  _buildItem() => Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 120),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(_context).size.width * .3,
                    child: Image.asset("assets/icons/chaire.png"),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 15, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nike aire condition super slycond ition  super slyc super slycondition super sly",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(text: "Size : 41"),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            text: "\$ " + "90 * 1",
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
              Text("1"),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: greyColor,
              ),
              CustomText(
                text: "\$ " + "90",
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
        ],
      );
}
