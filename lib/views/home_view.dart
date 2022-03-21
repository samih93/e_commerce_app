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
  HomeViewModelService homeViewModelService_Needed =
      Get.find<HomeViewModelService>();

  var searchtextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _context = context;
    return GetBuilder<HomeViewModelService>(
      init: Get.find<
          HomeViewModelService>(), // HomeViewModelService() --> loading from scratch but .find retreive it from memory

      builder: (homeViewModelService) => !homeViewModelService
              .isHomePageReady //  check if page is not ready
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
                        _SearchTextField(context),
                        SizedBox(
                          height: 40,
                        ),
                        CustomText(
                          text: "Categories",
                          fontSize: 24,
                          fontweight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _Categories(homeViewModelService.CategoryList),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "Products",
                              fontSize: 24,
                              fontweight: FontWeight.bold,
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
                        homeViewModelService.ProductList.length > 0
                            ? !homeViewModelService.isList
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
                                          homeViewModelService
                                              .ProductList[index],
                                          false);
                                    },
                                    itemCount:
                                        homeViewModelService.ProductList.length)
                                : ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return _ProductItem(
                                          homeViewModelService
                                              .ProductList[index],
                                          true);
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(height: 10),
                                    itemCount:
                                        homeViewModelService.ProductList.length)
                            : Text(
                                "No Products",
                                style: TextStyle(color: Colors.grey),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _SearchTextField(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade400,
        ),
        padding: EdgeInsetsDirectional.only(start: 17),
        child: TextFormField(
          onFieldSubmitted: (newValue) {
            print('search');
            FocusScope.of(context).unfocus();
            print(searchtextController.text);
            homeViewModelService_Needed
                .searchByProductName(newValue.trim().toString());
          },
          onChanged: (value) => {homeViewModelService_Needed.ontyping(value)},
          controller: searchtextController,
          style: TextStyle(fontSize: 23),
          decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: homeViewModelService_Needed.textserach != ""
                  ? IconButton(
                      onPressed: () {
                        print('close');
                        FocusScope.of(context).unfocus();

                        homeViewModelService_Needed.clearSearch();
                        searchtextController.clear();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    )
                  : SizedBox(
                      width: 0,
                    ),
              hintText: "Search ... "),
        ),
      ),
    );
  }

  Widget _Categories(List<Category> list) {
    return Container(
      height: 100,
      child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
                width: 20,
              ),
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _categoryItem(list[index]);
          }),
    );
  }

  _categoryItem(Category item) => InkWell(
        onTap: () {
          homeViewModelService_Needed.filterbyCategory(item.categoryId);
          // print(item.categoryId);
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: item.isselected ? primarycolor : Colors.grey.shade200,
              ),
              height: 60,
              width: 60,
              //ToDo:
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Image.network(
                  item.image.toString(),
                  //whatever image you can put here
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 15),
            CustomText(
              text: item.name,
              fontSize: 15,
              color: item.isselected ? primarycolor : Colors.black,
            ),
          ],
        ),
      );

  Widget _ProductItem(Product product, bool isList) {
    return Column(
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
                  height: isList ? 260 : 110,
                  child: new Image.network(
                    product.images.first.toString(),
                    //whatever image you can put here
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: product.name.toString().trim(),
                        alignment: Alignment.bottomLeft,
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        text: product.description.toString().trim(),
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
                                homeViewModelService_Needed
                                    .addProductTofavorite(
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
