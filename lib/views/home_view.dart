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
import 'package:e_commerce_app/widgets/animatedIcon.dart';

class HomeView extends StatelessWidget {
  BuildContext _context;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return GetBuilder<HomeViewModelService>(
      init: Get
          .find(), // HomeViewModelService() --> loading from scratch but .find retreive it from memory
      builder: (homeViewModelService) => homeViewModelService.IsLoding.value
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              backgroundColor: Colors.grey.shade300,
              body: Padding(
                padding: const EdgeInsets.only(
                    top: 40, left: 8, right: 8, bottom: 50),
                child: SingleChildScrollView(
                  child: Container(
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
                              text: "Products",
                              fontSize: 15,
                            ),
                            AnimIconBox(
                                name: 'list_view',
                                iconData: AnimatedIcons.list_view),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //_Products(),
                        !homeViewModelService.isList
                            ? GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 0.75,
                                ),
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return _ProductItem(
                                      homeViewModelService.ProductList[index]);
                                },
                                itemCount:
                                    homeViewModelService.ProductList.length)
                            : ListView.separated(
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return _ProductItem(
                                      homeViewModelService.ProductList[index]);
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 10),
                                itemCount:
                                    homeViewModelService.ProductList.length)
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
        color: Colors.grey.shade400,
      ),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            hintText: "Search ... "),
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

  Widget _ProductItem(Product product) {
    return GetBuilder<HomeViewModelService>(
      init: Get.find(),
      builder: (homeViewModelService) => Column(
        children: [
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                // boxShadow: [
                //   BoxShadow(blurRadius: 4),
                // ],
              ),
              //width: double.infinity,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(50),
                      color: Colors.grey.shade100,
                    ),
                    height: 100,
                    child: new Image.network(
                      product.image.toString(),
                      //whatever image you can put here
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CustomText(
                          text: product.name,
                          alignment: Alignment.bottomLeft,
                          fontSize: 20,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomText(
                          text: product.description,
                          alignment: Alignment.bottomLeft,
                          color: Colors.grey[800],
                          fontSize: 15,
                          maxLine: 2,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "${product.price} \$",
                                color: primarycolor,
                                alignment: Alignment.bottomLeft,
                                fontSize: 15,
                              ),
                              GestureDetector(
                                child: product.isfavorite
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : Icon(Icons.favorite_border),
                                onTap: () {
                                  homeViewModelService.addProductTofavorite(
                                      product, !product.isfavorite);

                                  //print(HomeViewModelService.isfavorite);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => Get.off(DetailsProduct(product: product)),
          ),
        ],
      ),
    );
  }

  // Widget buildproductItem() => Container(
  //       width: 60,
  //       child: Column(
  //         children: [
  //           Stack(
  //             alignment: Alignment.bottomRight,
  //             children: [
  //               CircleAvatar(
  //                 radius: 30,
  //                 backgroundImage: AssetImage("assets/icons/chaire.png"),
  //               ),
  //               // CircleAvatar(
  //               //   radius: 8,
  //               //   backgroundColor: Colors.white,
  //               // ),
  //               Padding(
  //                 padding: const EdgeInsetsDirectional.only(bottom: 4, end: 4),
  //                 child: CircleAvatar(
  //                   radius: 7,
  //                   backgroundColor: Colors.green,
  //                 ),
  //               )
  //             ],
  //           ),
  //           Text(
  //             "samih ahmad damaj",
  //             textAlign: TextAlign.center,
  //             maxLines: 2,
  //             overflow: TextOverflow.ellipsis,
  //           ),
  //         ],
  //       ),
  //     );
}
