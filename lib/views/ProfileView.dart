import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/Controller/ProfileController.dart';
import 'package:e_commerce_app/helper/localStorageUserData.dart';
import 'package:e_commerce_app/service/HomeViewModelService.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
//import 'package:flutter_badged/flutter_badge.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (ProfileController) => Scaffold(
        body: Container(
          // padding: EdgeInsets.only(top: 22),
          child: Column(
            //ToDo:
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.green.shade900,
                      Colors.green.shade700,
                      Colors.green.shade400,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: ProfileController.userModel != null &&
                                    ProfileController.userModel.pic != ""
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
                      text: ProfileController.userModel != null
                          ? ProfileController.userModel.name ?? ""
                          : "",
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: ProfileController.userModel != null
                          ? ProfileController.userModel.email ?? ""
                          : "",
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
                      title: Text("Profile"),
                      leading: Icon(Icons.account_box),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () {},
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                    ListTile(
                      title: Text("Shipping Address"),
                      leading: Icon(Icons.location_on_outlined),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () {},
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                    ListTile(
                      title: Text("Orders"),
                      leading: Icon(Icons.list),
                      trailing: FlutterBadge(
                        icon: Icon(
                          Icons.message,
                          size: 30,
                        ),
                        itemCount: 0,
                        hideZeroCount: false,
                        badgeColor: primarycolor,
                        borderRadius: 20.0,
                      ),
                      onTap: () {},
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                    GetBuilder<HomeViewModelService>(
                      init: Get.find(),
                      builder: (homeViewModelService) => ListTile(
                        title: Text("Wish List"),
                        leading: Icon(Icons.favorite_border),
                        trailing: FlutterBadge(
                          icon: Icon(
                            Icons.favorite_outlined,
                            size: 30,
                          ),
                          itemCount: homeViewModelService.favoriteproduct !=
                                  null
                              ? homeViewModelService.favoriteproduct.length ?? 0
                              : 0,
                          hideZeroCount: false,
                          badgeColor: primarycolor,
                          borderRadius: 20.0,
                        ),
                        onTap: () {},
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                    ListTile(
                      title: Text("Payment Method"),
                      leading: Icon(Icons.payment),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: ListTile(
                  title: Center(
                    child: Text(
                      "Sign Out",
                    ),
                  ),
                  tileColor: primarycolor,
                  onTap: () => ProfileController.SignOut(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
