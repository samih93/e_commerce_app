import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/models/favoriteProduct.dart';
import 'package:e_commerce_app/service/HomeViewModelService.dart';
import 'package:e_commerce_app/views/CartView.dart';
import 'package:e_commerce_app/views/auth/ControlView.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:toast/toast.dart';

class WishList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModelService>(
      init: Get.find(),
      builder: (homeViewModelService) => Scaffold(
        appBar: AppBar(
          actions: [
            GetBuilder<CartController>(
              init: Get.find(),
              builder: (cartController) => Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(() => CartView()),
                    child: FlutterBadge(
                      icon: Image.asset(
                        "assets/icons/Icon_Cart.png",
                        fit: BoxFit.fill,
                      ),
                      itemCount: cartController.cartproductList != null
                          ? cartController.cartproductList.length ?? 0
                          : 0,
                      hideZeroCount: false,
                      badgeColor: primarycolor,
                      borderRadius: 20.0,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () => Get.off(() => ControlView()),
                      child: Icon(
                        Icons.home,
                        color: primarycolor,
                        size: 30,
                      )),
                ],
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Get.off(ControlView()) //Get.off(page),
              ),
          title: CustomText(
              text: "Wish List",
              color: primarycolor,
              alignment: Alignment.centerLeft),
        ),
        body: homeViewModelService.favoriteproduct.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svg/emty card.svg",
                    alignment: Alignment.center,
                    width: 200,
                    height: 240,
                  ),
                  SizedBox(height: 15),
                  CustomText(
                    text: "Wish List is Empty",
                    fontSize: 25,
                    alignment: Alignment.center,
                  ),
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: ListView.separated(
                        itemCount: homeViewModelService.favoriteproduct.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              //TODo:
                              // Get.off(DetailsProduct(
                              //   product: Product(
                              //       id: cartcontroller
                              //           .cardproductList[index].productId,
                              //       name: cartcontroller
                              //           .cardproductList[index].name,
                              //       image: cartcontroller
                              //           .cardproductList[index].image,
                              //       description: cartcontroller
                              //           .cardproductList[index].description,
                              //       color: cartcontroller
                              //           .cardproductList[index].color,
                              //       sizes: [],
                              //       //     cartcontroller.listOfSizesOfproduct,
                              //       price: cartcontroller
                              //           .cardproductList[index].price),
                              // ));
                            },
                            child: Container(
                              height: 120,
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    child: homeViewModelService
                                                .favoriteproduct[index]
                                                .product
                                                .image !=
                                            ""
                                        ? Image.network(homeViewModelService
                                            .favoriteproduct[index]
                                            .product
                                            .image)
                                        : Image.asset(
                                            "assets/icons/chaire.png"),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .44,
                                    padding: EdgeInsets.only(top: 15, left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          homeViewModelService
                                              .favoriteproduct[index]
                                              .product
                                              .name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          text: "\$ " +
                                              homeViewModelService
                                                  .favoriteproduct[index]
                                                  .product
                                                  .price,
                                          color: primarycolor,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  Expanded(
                                    flex: 1,
                                    child: GetBuilder<HomeViewModelService>(
                                      init: Get.find(),
                                      builder: (homeViewModelService) =>
                                          GestureDetector(
                                              child: Container(
                                                child: Icon(
                                                  Icons.delete,
                                                  color: primarycolor,
                                                ),
                                              ),
                                              onTap: () {
                                                var alertStyle = AlertStyle(
                                                    animationDuration: Duration(
                                                        milliseconds: 1));
                                                Alert(
                                                  style: alertStyle,
                                                  context: context,
                                                  type: AlertType.error,
                                                  title: "Delete Item",
                                                  desc:
                                                      "Are You Sure You Want To remove This Item from Wish List",
                                                  buttons: [
                                                    DialogButton(
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      color:
                                                          Colors.blue.shade400,
                                                    ),
                                                    DialogButton(
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18),
                                                      ),
                                                      onPressed: () {
                                                        homeViewModelService
                                                            .addProductTofavorite(
                                                                homeViewModelService
                                                                        .ProductList[
                                                                    index],
                                                                false);
                                                        Navigator.pop(context);
                                                        Toast.show(
                                                            "Item Removed from favorite",
                                                            context,
                                                            duration: 2,
                                                            backgroundColor:
                                                                Colors.red,
                                                            gravity: Toast.TOP);
                                                      },
                                                      color:
                                                          Colors.red.shade400,
                                                    ),
                                                  ],
                                                ).show();
                                              }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
