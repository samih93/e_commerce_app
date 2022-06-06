import 'package:e_commerce_app/shared/Constant.dart';
import 'package:flutter/material.dart';

class CustomGradientText extends StatelessWidget {
  final String text;

  final double fontSize;

  final Alignment alignment;

  final int maxLine;
  final double height;
  final FontWeight fontweight;

  CustomGradientText(
      {this.text = '',
      this.fontSize = 16,
      this.alignment = Alignment.topLeft,
      this.maxLine = 1,
      this.height = 1,
      this.fontweight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          height: height,
          fontSize: fontSize,
          fontWeight: fontweight,
          foreground: Paint()..shader = linearGradient),
      maxLines: maxLine,
    );
  }

  final Shader linearGradient = LinearGradient(
    colors: primarygradient,
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
}
