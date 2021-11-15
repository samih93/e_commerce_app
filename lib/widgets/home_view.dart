import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/models/Category.dart';
import 'package:e_commerce_app/service/ApplicationDb.dart';
import 'package:e_commerce_app/service/HomeViewModelService.dart';
import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final List<String> _CategoriesList = <String>[
    'shoes',
    'sport',
    'home',
    'football',
    'fitness'
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplicationDb>(
      init: ApplicationDb(),
      builder: (ApplicationDb) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
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
        ),
      ),
    );
  }

  Widget _SearchTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
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
      child: GetBuilder<HomeViewModelService>(
        init: HomeViewModelService(),
        builder: (HomeViewModelService) =>
            HomeViewModelService.categoryIsLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                          width: 20,
                        ),
                    itemCount: HomeViewModelService.CategoryList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey.shade200,
                            ),
                            height: 60,
                            width: 60,
                            //ToDo:
                            child: Image.network(
                              HomeViewModelService.CategoryList[index].image
                                  .toString(),
                              //whatever image you can put here
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(height: 15),
                          CustomText(
                            text: HomeViewModelService.CategoryList[index].name,
                            fontSize: 15,
                          ),
                        ],
                      );
                    }),
      ),
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
