// @dart=2.9

import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/Controller/AuthController.dart';
import 'package:e_commerce_app/views/auth/SignUpView.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustomTextFormField.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';

class LoginView extends GetWidget<AuthController> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
                GestureDetector(
                  onTap: () {
                    controller.facebookSignInMethod();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade800,
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(children: [
                          Icon(
                            Icons.facebook,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Sign in with facebook",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    controller.facebookSignInMethod();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 6,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(children: [
                          Image.asset("assets/images/google.png"),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Sign in with google",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
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
