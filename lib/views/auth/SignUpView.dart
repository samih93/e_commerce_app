import 'package:e_commerce_app/helper/localStorageUserData.dart';
import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/Controller/AuthController.dart';
import 'package:e_commerce_app/shared/style.dart';
import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustomTextFormField.dart';
import 'package:e_commerce_app/widgets/CustumButton_with_social_Media.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:e_commerce_app/widgets/cutom_greadient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends GetWidget<AuthController> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
                    CustomGradientText(
                      text: "Sign Up",
                      fontSize: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  text: 'Name',
                  hint: "Name ...",
                  onSave: (Value) => controller.name = Value!,
                  validator: (value) {
                    if (value!.isEmpty) return "Name must be not empty";
                  },
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  text: 'Email',
                  hint: "..........@gmail.com",
                  onSave: (Value) => controller.email = Value!,
                  validator: (value) {
                    if (value!.isEmpty) return "Email must be not empty";
                  },
                ),
                SizedBox(height: 15),
                CustomTextFormField(
                  text: 'Password',
                  hint: "*********",
                  onSave: (Value) => controller.password = Value!,
                  validator: (value) {
                    if (value!.isEmpty) return "Password must be not empty";
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                GetBuilder<AuthController>(
                  init: Get.find<AuthController>(),
                  builder: (authcontroller) => authcontroller
                          .isloadingCreateAccount
                      ? CircularProgressIndicator()
                      : CustomButton(
                          text: "Sign Up",
                          onPress: () async {
                            _formkey.currentState?.save();
                            if (_formkey.currentState!.validate())
                              await controller.CreateAccount().then((value) {
                                if (value != null)
                                  controller.saveuserThenNavigate(value);
                                else
                                  myCustomSnackbar(
                                      title: "Error Login Account",
                                      body: controller.errorMessage.toString(),
                                      type: toastType.Error);
                              });
                          }),
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
