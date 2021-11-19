// @dart=2.9

import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/Controller/AuthController.dart';
import 'package:e_commerce_app/views/auth/SignUpView.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustomTextFormField.dart';
import 'package:e_commerce_app/widgets/CustumButton_with_social_Media.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetWidget<AuthController> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                    GestureDetector(
                      onTap: () => Get.off(SignUpView()),
                      child: CustomText(
                        text: "Sign up",
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
                  onSave: (Value) => controller.email = Value,
                  validator: (value) {},
                ),
                SizedBox(height: 30),
                CustomTextFormField(
                  text: 'Password',
                  hint: "*********",
                  onSave: (Value) => controller.password = Value,
                  validator: (Value) {},
                ),
                SizedBox(height: 15),
                CustomText(
                  text: "Forgot Password",
                  alignment: Alignment.topRight,
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButton(
                    text: "Sign In",
                    onPress: () {
                      _formkey.currentState.save();
                      if (_formkey.currentState.validate())
                        controller.SignInWithEmailAndPassword();
                    }),
                SizedBox(
                  height: 30,
                ),
                CustomText(
                  text: "Or continue with",
                  color: Colors.grey.shade400,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.facebookSignInMethod();
                        },
                        icon: Image.asset("assets/images/facebook.png")),
                    IconButton(
                        onPressed: () {
                          controller.googleSignInMethod();
                        },
                        icon: Image.asset("assets/images/google.png")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
