import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomText(
        text: "Profile View",
        alignment: Alignment.center,
        fontSize: 20,
      ),
    );
  }
}
