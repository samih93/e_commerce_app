import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  FirebaseAuth _Auth = FirebaseAuth.instance;
  final List<String> _CategoriesList = <String>[
    'shoes',
    'sport',
    'home',
    'football',
    'fitness'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, right: 20, left: 20),
        child: Column(
          children: [
            _SearchTextField(),
            SizedBox(
              height: 40,
            ),
            CustomText(
              text: "Categories",
              fontSize: 18,
            ),
            _Categories(),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Best Selling",
                  fontSize: 15,
                ),
                CustomText(
                  text: "See All",
                  fontSize: 15,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            _Products(),
          ],
        ),
      ),
    );
  }

  Widget _SearchTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade100,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _Categories() {
    return Container(
      height: 100,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                width: 20,
              ),
          itemCount: _CategoriesList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey.shade100,
                  ),
                  height: 60,
                  width: 60,
                  child: Image.asset('assets/icons/Icon_Mens Shoe.png'),
                ),
                SizedBox(height: 15),
                CustomText(
                  text: _CategoriesList[index],
                  fontSize: 15,
                ),
              ],
            );
          }),
    );
  }

  Widget _Products() {
    return Container(
      height: 305,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                width: 20,
              ),
          itemCount: _CategoriesList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: MediaQuery.of(context).size.width * .4,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey.shade100,
                    ),
                    child: Image.asset('assets/icons/chaire.png',
                        fit: BoxFit.fill),
                  ),
                  SizedBox(height: 5),
                  CustomText(
                    text: _CategoriesList[index],
                    alignment: Alignment.bottomLeft,
                    fontSize: 20,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    text: _CategoriesList[index],
                    alignment: Alignment.bottomLeft,
                    color: Colors.grey[800],
                    fontSize: 15,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    text: "\$755",
                    color: primarycolor,
                    alignment: Alignment.bottomLeft,
                    fontSize: 15,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
