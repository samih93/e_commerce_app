import 'package:e_commerce_app/Controller/HomeController.dart';
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
      ),
    );
  }
}
