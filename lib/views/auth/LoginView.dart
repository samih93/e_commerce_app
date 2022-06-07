import 'package:e_commerce_app/Controller/AuthController.dart';
import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/shared/style.dart';
import 'package:e_commerce_app/views/auth/SignUpView.dart';
import 'package:e_commerce_app/views/auth/forgot_password_screen.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:e_commerce_app/widgets/cutom_greadient_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
                    CustomGradientText(text: "Welcome", fontSize: 30),
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
                  validator: (value) {
                    if (value!.isEmpty) return "email must not be empty";
                  },
                  onSaved: (Value) => controller.email = Value!,
                ),
                SizedBox(height: 30),
                GetBuilder<AuthController>(
                  init: Get.find<AuthController>(),
                  builder: (authcontroller) => TextFormField(
                    obscureText: authcontroller.showpassword,
                    validator: (value) {
                      if (value!.isEmpty) return "password must not be empty";
                    },
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
                    onSaved: (Value) => controller.password = Value!,
                  ),
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Get.to(ForgetPasswordScreen());
                  },
                  child: CustomText(
                    text: "Forgot Password?",
                    color: Colors.grey.shade700,
                    alignment: Alignment.topRight,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GetBuilder<AuthController>(
                  init: Get.find<AuthController>(),
                  builder: (authcontroller) => authcontroller.isloadingSignIn
                      ? CircularProgressIndicator(
                          color: primarycolor,
                        )
                      : CustomButton(
                          text: "Sign In",
                          onPress: () async {
                            _formkey.currentState?.save();
                            if (_formkey.currentState!.validate()) {
                              await controller.SignInWithEmailAndPassword()
                                  .then((value) {
                                if (value != null) {
                                  authcontroller.saveuserThenNavigate(value);
                                } else
                                  myCustomSnackbar(
                                      title: "Error Login Account",
                                      body: authcontroller.errorMessage
                                          .toString(),
                                      type: toastType.Error);
                              });
                            }
                          }),
                ),
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
                controller.isloadingsigninwithfacebook
                    ? CircularProgressIndicator()
                    : GestureDetector(
                        onTap: () async {
                          await controller.facebookSignInMethod().then((value) {
                            if (value != null) {
                              controller.saveuserThenNavigate(value);

                              myCustomSnackbar(
                                  title: "You have successfully logged in",
                                  body: "Welcome '${value.name}'",
                                  type: toastType.Success);
                            } else
                              myCustomSnackbar(
                                  title: "Error Login Account",
                                  body: controller.errorMessage.toString(),
                                  type: toastType.Error);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                GetBuilder<AuthController>(
                  init: Get.find<AuthController>(),
                  builder: (authcontroller) => authcontroller
                          .isloadingsigninwithgoogle
                      ? CircularProgressIndicator(
                          color: primarycolor,
                        )
                      : GestureDetector(
                          onTap: () async {
                            await controller.googleSignInMethod().then((value) {
                              if (value != null) {
                                controller.saveuserThenNavigate(value);
                                myCustomSnackbar(
                                    title: "You have successfully logged in",
                                    body: "Welcome '${value.name}'",
                                    type: toastType.Success);
                              } else
                                myCustomSnackbar(
                                    title: "Error Login Account",
                                    body:
                                        "${controller.errorMessage.toString()}",
                                    type: toastType.Error);
                            });
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ),
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
