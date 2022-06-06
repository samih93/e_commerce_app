import 'package:e_commerce_app/shared/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

TextStyle get greyColor => TextStyle(color: Colors.grey);

void myCustomSnackbar(
    {toastType type, String title, String body, SnackPosition snackPosition}) {
  Get.snackbar(
    "$title",
    "$body",
    snackPosition: snackPosition ?? SnackPosition.TOP,
    backgroundColor: type == toastType.Success
        ? primarycolor.shade500.withOpacity(0.7)
        : type == toastType.Error
            ? Colors.red.shade500.withOpacity(0.7)
            : Colors.orange.shade500.withOpacity(0.7),
    colorText: Colors.white,
  );
}

enum toastType {
  Error,
  Warning,
  Success,
}
