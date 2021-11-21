import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/Controller/ProfileController.dart';
import 'package:e_commerce_app/service/localStorageUserData.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (ProfileController) => Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 22),
          child: Column(
            //ToDo:
            children: [
              Container(
                padding: EdgeInsets.all(20),
                color: primarycolor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: ProfileController.userModel.pic != ""
                                ? NetworkImage(ProfileController.userModel.pic)
                                : AssetImage(
                                    "assets/images/default profile.png",
                                  ),
                            fit: BoxFit.fill),
                        //whatever image you can put here
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CustomText(
                      text: ProfileController.userModel.name ??
                          ProfileController.userModel.name,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: ProfileController.userModel.email ??
                          ProfileController.userModel.email,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                      title: Text("Shipping Address"),
                      leading: Icon(Icons.add_location),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text("Orders"),
                      leading: Icon(Icons.list),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Center(
                        child: Text(
                          "Sign Out",
                        ),
                      ),
                      tileColor: primarycolor,
                      onTap: () => ProfileController.SignOut(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
