// @dart=2.9

import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/Controller/AuthController.dart';
import 'package:e_commerce_app/views/auth/SignUpView.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustomTextFormField.dart';
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
        padding: const EdgeInsets.all(20),
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
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  onSaved: (Value) => controller.email = Value,
                ),
                SizedBox(height: 30),
                GetBuilder<AuthController>(
                  init: Get.find(),
                  builder: (authcontroller) => TextFormField(
                    obscureText: authcontroller.showpassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          authcontroller.showpassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          authcontroller.onchangepasswordvisibility();
                          print(authcontroller.showpassword);
                        },
                      ),
                    ),
                    onSaved: (Value) => controller.password = Value,
                  ),
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
