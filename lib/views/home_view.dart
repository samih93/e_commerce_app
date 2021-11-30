// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/models/Category.dart';
import 'package:e_commerce_app/models/Product.dart';
import 'package:e_commerce_app/service/ApplicationDb.dart';
import 'package:e_commerce_app/service/HomeViewModelService.dart';
import 'package:e_commerce_app/views/DetailsProduct.dart';
import 'package:e_commerce_app/views/auth/LoginView.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModelService>(
      init: Get
          .find(), // HomeViewModelService() --> loading from scratch but .find retreive it from memory
      builder: (HomeViewModelService) => HomeViewModelService.IsLoding.value
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: SingleChildScrollView(
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

        //   circular progress bar into category
        // GetBuilder<HomeViewModelService>(init: HomeViewModelService(),builder: )(HomeViewModelService) => HomeViewModelService.IsLoding.value
        //     ? Center(
        //         child: CircularProgressIndicator(
        //           color: Colors.blue,
        //         ),
        //       )
        builder: (HomeViewModelService) => ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
                  width: 20,
                ),
            itemCount: HomeViewModelService.CategoryList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // HomeViewModelService.getProducts(
                      //     HomeViewModelService.CategoryList[index].categoryId);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey.shade200,
                      ),
                      height: 60,
                      width: 60,
                      //ToDo:
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new Image.network(
                          HomeViewModelService.CategoryList[index].image
                              .toString(),
                          //whatever image you can put here
                          fit: BoxFit.fill,
                        ),
                      ),
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
      child: GetBuilder<HomeViewModelService>(
        init: HomeViewModelService(),
        //   circular progress bar into product

        // builder: (HomeViewModelService) => HomeViewModelService.IsLoding.value
        //     ? Center(child: CircularProgressIndicator())
        builder: (HomeViewModelService) => ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
                  width: 20,
                ),
            itemCount: HomeViewModelService.ProductList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Get.off(DetailsProduct(
                    product: HomeViewModelService.ProductList[index])),
                child: Container(
                  width: MediaQuery.of(context).size.width * .6,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey.shade100,
                          ),
                          height: 230,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: new Image.network(
                              HomeViewModelService.ProductList[index].image
                                  .toString(),
                              //whatever image you can put here
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      CustomText(
                        text: HomeViewModelService.ProductList[index].name,
                        alignment: Alignment.bottomLeft,
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        text:
                            HomeViewModelService.ProductList[index].description,
                        alignment: Alignment.bottomLeft,
                        color: Colors.grey[800],
                        fontSize: 15,
                        maxLine: 3,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text:
                                  "${HomeViewModelService.ProductList[index].price} \$",
                              color: primarycolor,
                              alignment: Alignment.bottomLeft,
                              fontSize: 15,
                            ),
                            GestureDetector(
                              child: HomeViewModelService
                                      .ProductList[index].isfavorite
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Icon(Icons.favorite_border),
                              onTap: () {
                                HomeViewModelService.addProductTofavorite(
                                    HomeViewModelService.ProductList[index],
                                    !HomeViewModelService
                                        .ProductList[index].isfavorite);

                                //print(HomeViewModelService.isfavorite);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
