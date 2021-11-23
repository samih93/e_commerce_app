import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  List<String> cardList = ["samih", "ahmad", "damaj", "ali", "samih", "dani"];
  List<String> images = [
    "assets/images/default profile.png",
    "assets/images/default profile.png",
    "assets/images/default profile.png",
    "assets/images/default profile.png",
    "assets/images/default profile.png",
    "assets/images/default profile.png",
  ];

  List<int> prices = [100, 200, 300, 400, 500, 600];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: ListView.separated(
                itemCount: cardList.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    child: Row(
                      children: [
                        Image.asset(images[index]),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: cardList[index],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: "\$ " + prices[index].toString(),
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
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 15),
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
