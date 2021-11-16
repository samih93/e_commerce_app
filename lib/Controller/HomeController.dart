import 'package:e_commerce_app/views/CardView.dart';
import 'package:e_commerce_app/views/ProfileView.dart';
import 'package:e_commerce_app/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int _navigatorValue = 0;
  Widget _currentScreen = HomeView();

  get currentscreen => _currentScreen;

  get navigatorvalue => _navigatorValue;
  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        _currentScreen = HomeView();
        break;
      case 1:
        _currentScreen = CardView();
        break;
      case 2:
        _currentScreen = ProfileView();
        break;
    }
    update();
  }
}
