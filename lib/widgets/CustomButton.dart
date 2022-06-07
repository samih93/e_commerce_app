import 'package:e_commerce_app/shared/Constant.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/widgets/CustumText.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPress;
  Color? color;

  CustomButton({this.text, this.onPress, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: color == null
            ? LinearGradient(colors: primarygradient)
            : LinearGradient(colors: [
                color!,
                color!,
              ]),
      ),
      child: MaterialButton(
        height: 50,
        onPressed: onPress,
        // color: color ?? primarycolor,
        textColor: Colors.white,

        child: CustomText(
          text: text ?? '',
          color: Colors.white,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
