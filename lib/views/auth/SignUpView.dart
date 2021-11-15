import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/Controller/AuthController.dart';
import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustomTextFormField.dart';
import 'package:e_commerce_app/widgets/CustumButton_with_social_Media.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends GetWidget<AuthController> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Get.off(LoginView()),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  text: 'Name',
                  hint: "Name ...",
                  onSave: (Value) => controller.name = Value,
                  validator: (value) {},
                ),
                SizedBox(height: 30),
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
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                    text: "Sign Up",
                    onPress: () {
                      _formkey.currentState.save();
                      if (_formkey.currentState.validate())
                        controller.CreateAccount();
                    }),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
