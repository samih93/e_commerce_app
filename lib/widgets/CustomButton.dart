// @dart=2.9

import 'package:e_commerce_app/Constant.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/widgets/CustumText.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  CustomButton({this.text, this.onPress});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPress,
      color: primarycolor,
      textColor: Colors.white,
      padding: EdgeInsets.all(18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomText(
        text: text,
        color: Colors.white,
        alignment: Alignment.center,
      ),
    );
  }
}
