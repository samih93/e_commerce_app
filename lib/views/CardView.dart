import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: CustomText(
        alignment: Alignment.center,
        text: "Card View",
        fontSize: 20,
      )),
    );
  }
}
