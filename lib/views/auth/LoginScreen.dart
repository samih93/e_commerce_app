import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/widgets/CustomTextFormField.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                Text(
                  "Sign up",
                  style: TextStyle(
                    color: primarycolor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              text: 'Email',
              hint: "..........@gmail.com",
              onSave: (value) {},
              validator: (value) {},
            ),
            SizedBox(height: 30),
            CustomTextFormField(
              text: 'Password',
              hint: "*********",
              onSave: (value) {},
              validator: (value) {},
            ),
            SizedBox(height: 15),
            CustomText(
              text: "Forgot Password",
              alignment: Alignment.topRight,
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              onPressed: () {},
              color: primarycolor,
              textColor: Colors.white,
              child: CustomText(
                text: "Sign In",
                color: Colors.white,
                alignment: Alignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
