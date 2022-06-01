import 'package:e_commerce_app/Controller/AuthController.dart';
import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:toast/toast.dart';

class ForgetPasswordScreen extends GetWidget<AuthController> {
  var emailControllerText = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Receive an email to reset your password"),
                SizedBox(height: 10),
                TextFormField(
                  controller: emailControllerText,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
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
                    if (_formkey.currentState.validate()) {
                      final bool isValid = EmailValidator.validate(
                          emailControllerText.text.toString().trim());
                      if (isValid) {
                        await controller.resetpasword(
                            emailControllerText.text.toString().trim());
                        Toast.show("Password reset email sent ", context,
                            duration: 2,
                            backgroundColor: Colors.green,
                            gravity: Toast.CENTER);
                        Get.off(LoginView());
                      } else {
                        Toast.show("please Enter a valid email", context,
                            duration: 2,
                            backgroundColor: Colors.red,
                            gravity: Toast.CENTER);
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
