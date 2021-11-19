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
                color: Colors.blueAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
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
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: ProfileController.userModel.email ??
                          ProfileController.userModel.email,
                      color: Colors.grey.shade800,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomButton(
                  text: "Signout", onPress: () => ProfileController.SignOut()),
            ],
          ),
        ),
      ),
    );
  }
}
