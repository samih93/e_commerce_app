import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';

class CustomButtonWithSocial extends StatelessWidget {
  final String text;
  final String imagename;
  final VoidCallback onpress;

  CustomButtonWithSocial(
      {required this.text, required this.imagename, required this.onpress});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: FlatButton(
        onPressed: onpress,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Image.asset("assets/images/" + imagename),
            SizedBox(
              width: 90,
            ),
            CustomText(
              text: text,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
