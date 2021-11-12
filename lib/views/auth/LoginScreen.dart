import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/viewmodel/AuthViewModel.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustomTextFormField.dart';
import 'package:e_commerce_app/widgets/CustumButton_with_social_Media.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                Text(
                  "Sign up",
                  style: TextStyle(
                    color: primarycolor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              text: 'Email',
              hint: "..........@gmail.com",
              onSave: () => {},
              validator: () => {},
            ),
            SizedBox(height: 30),
            CustomTextFormField(
              text: 'Password',
              hint: "*********",
              onSave: () => {},
              validator: () => {},
            ),
            SizedBox(height: 15),
            CustomText(
              text: "Forgot Password",
              alignment: Alignment.topRight,
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton(text: "Sign In", onPress: () {}),
            SizedBox(
              height: 30,
            ),
            CustomButtonWithSocial(
              text: "Sign In With Facebook",
              imagename: "facebook.png",
              onpress: () {},
            ),
            SizedBox(
              height: 30,
            ),
            CustomButtonWithSocial(
              text: "Sign In With google",
              imagename: "google.png",
              onpress: () {
                controller.googleSignInMethod();
              },
            ),
          ],
        ),
      ),
    );
  }
}
