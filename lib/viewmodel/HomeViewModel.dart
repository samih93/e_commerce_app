import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  int _navigatorValue = 0;

  get navigatorvalue => _navigatorValue;
  void chnageSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    update();
  }
}
