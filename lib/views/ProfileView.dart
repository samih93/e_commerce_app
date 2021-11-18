import 'package:e_commerce_app/Controller/ProfileController.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ProfileController>(
            init: ProfileController(),
            builder: (ProfileController) => CustomButton(
                text: "Signout", onPress: () => ProfileController.SignOut())));
  }
}
