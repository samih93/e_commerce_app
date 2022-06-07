import 'package:e_commerce_app/Controller/AuthController.dart';
import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/shared/style.dart';
import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ForgetPasswordScreen extends GetWidget<AuthController> {
  var emailControllerText = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        flexibleSpace: Container(
          decoration:
              BoxDecoration(gradient: LinearGradient(colors: primarygradient)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12, top: 40),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Receive an email to reset your password"),
                SizedBox(height: 10),
                TextFormField(
                  controller: emailControllerText,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email must not be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: "Reset Password",
                  onPress: () async {
                    if (_formkey.currentState!.validate()) {
                      final bool isValid = EmailValidator.validate(
                          emailControllerText.text.toString().trim());
                      if (isValid) {
                        await controller
                            .resetpasword(
                                emailControllerText.text.toString().trim())
                            .then((value) {
                          myCustomSnackbar(
                              type: toastType.Success,
                              title: "Password reset email sent");

                          Get.off(LoginView());
                        }).catchError((error) {
                          myCustomSnackbar(
                              type: toastType.Error,
                              title: "${error.toString()}");
                        });
                      } else {
                        myCustomSnackbar(
                            duration: 4,
                            type: toastType.Success,
                            title: "Password reset email sent");
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
