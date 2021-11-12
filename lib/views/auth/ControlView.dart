import 'package:e_commerce_app/viewmodel/AuthViewModel.dart';
import 'package:e_commerce_app/views/auth/LoginScreen.dart';
import 'package:e_commerce_app/widgets/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlView extends GetWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user != null)
          ? HomeView()
          : LoginScreen();
    });
  }
}
