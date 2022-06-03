// @dart=2.9

import 'package:e_commerce_app/shared/Constant.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/widgets/CustumText.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  Color color;

  CustomButton({this.text, this.onPress, this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      onPressed: onPress,
      color: color ?? primarycolor,
      textColor: Colors.white,
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
