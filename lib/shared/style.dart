import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

TextStyle get greyColor => TextStyle(color: Colors.grey);

void myCustomSnackbar(
    {toastType type, String title, String body, SnackPosition snackPosition}) {
  Get.snackbar(
    "$title",
    "$body",
    snackPosition: snackPosition ?? SnackPosition.BOTTOM,
    backgroundColor: type == toastType.Success
        ? Colors.green.shade500
        : type == toastType.Error
            ? Colors.red.shade500
            : Colors.orange.shade500,
    colorText: Colors.white,
  );
}

enum toastType {
  Error,
  Warning,
  Success,
}
