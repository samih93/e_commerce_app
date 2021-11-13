import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  FirebaseAuth _Auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Screen"),
        ),
        body: Column(
          children: [
            Center(child: Text("Home View")),
            FlatButton(
              child: Text("Logout"),
              onPressed: () {
                _Auth.signOut();
                Get.offAll(LoginView());
              },
            )
          ],
        ));
  }
}
