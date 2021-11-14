import 'package:e_commerce_app/viewmodel/HomeViewModel.dart';
import 'package:e_commerce_app/views/auth/ControlView.dart';
import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:e_commerce_app/widgets/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helper/Binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // bind the dependency to check if user != null
      initialBinding: Binding(),
      home: Scaffold(
        body: ControlView(),
        bottomNavigationBar: _bottomNavogationbar(),
      ),
    );
  }

  Widget _bottomNavogationbar() {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (Controller) => BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text("Explore"),
            ),
            label: "",
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                "assets/icons/Icon_Explore.png",
                fit: BoxFit.fill,
                width: 20,
              ),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text("card"),
            ),
            label: "",
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                "assets/icons/Icon_Cart.png",
                fit: BoxFit.fill,
                width: 20,
              ),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text("Account"),
            ),
            label: "",
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                "assets/icons/Icon_User.png",
                fit: BoxFit.fill,
                width: 20,
              ),
            ),
          ),
        ],
        currentIndex: Controller.navigatorvalue,
        onTap: (index) => {
          Controller.changeSelectedValue(index),
          print(Controller.navigatorvalue)
        },
        elevation: 0,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.grey.shade50,
      ),
    );
  }
}
