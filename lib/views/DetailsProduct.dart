import 'package:e_commerce_app/layout/layout.dart';
import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/Controller/CartController.dart';
import 'package:e_commerce_app/models/CartProduct.dart';
import 'package:e_commerce_app/models/Product.dart';
import 'package:e_commerce_app/service/HomeViewModelService.dart';
import 'package:e_commerce_app/service/sqflitedatabase/EcommerceDatabasehelper.dart';
import 'package:e_commerce_app/shared/style.dart';
import 'package:e_commerce_app/views/CartView.dart';
import 'package:e_commerce_app/views/home_view.dart';
import 'package:e_commerce_app/widgets/CustomButton.dart';
import 'package:e_commerce_app/widgets/CustumText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toast/toast.dart';

class DetailsProduct extends StatelessWidget {
  Product? product;

  DetailsProduct({this.product});

  var boardContorller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              BoxDecoration(gradient: LinearGradient(colors: primarygradient)),
        ),
        // backgroundColor: primarycolor,
        // leading: IconButton(
        //     icon: Icon(
        //       Icons.arrow_back,
        //       color: Colors.white,
        //     ),
        //     onPressed: () => Get.off(EcommerceLayout()) //Get.off(page),
        //     ),
        actions: [
          GetBuilder<CartController>(
            init: Get.find<CartController>(),
            builder: (cartController) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GetBuilder<HomeViewModelService>(
                  init: Get.find<HomeViewModelService>(),
                  builder: (homeViewModelService) => GestureDetector(
                    child: product!.isfavorite!
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(Icons.favorite_border),
                    onTap: () {
                      homeViewModelService.addProductTofavorite(
                          product!, !product!.isfavorite!);
                      if (!product!.isfavorite! == true) {
                        myCustomSnackbar(
                            duration: 1,
                            snackPosition: SnackPosition.BOTTOM,
                            type: toastType.Success,
                            title: "Added To favorite");
                      } else {
                        myCustomSnackbar(
                            duration: 1,
                            snackPosition: SnackPosition.BOTTOM,
                            type: toastType.Success,
                            title: "Removed from favorite");
                      }

                      //print(HomeViewModelService.isfavorite);
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () => Get.to(() => CartView()),
                  child: FlutterBadge(
                    icon: Icon(Icons.shopping_bag),
                    itemCount: cartController.cartproductList != null
                        ? cartController.cartproductList.length
                        : 0,
                    hideZeroCount: false,
                    badgeColor: Colors.red.shade300,
                    borderRadius: 20.0,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    onTap: () => Get.off(() => EcommerceLayout()),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0, right: 5),
                      child: Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 30,
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: PageView.builder(
                            physics: BouncingScrollPhysics(),
                            controller: boardContorller,
                            onPageChanged: (value) {
                              print(value);
                            },
                            itemBuilder: (context, index) => _images_of_product(
                                context, product!.images![index]),
                            itemCount: product!.images!.length),
                      ),
                      if (product!.images!.length > 1)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SmoothPageIndicator(
                            effect: WormEffect(
                                dotColor: Colors.grey.withOpacity(0.4),
                                activeDotColor: primarycolor.withOpacity(0.4)),
                            controller: boardContorller,
                            count: product!.images!.length,
                          ),
                        ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        CustomText(
                          text: product!.name.toString(),
                          fontSize: 25,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15, bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: GetBuilder<CartController>(
                            init: Get.find<CartController>(),
                            builder: (cartcontroller) => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Size",
                                  alignment: Alignment.centerLeft,
                                  fontSize: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CustomText(
                                  text: cartcontroller.selectedSize,
                                  color: Colors.grey,
                                  fontSize: 22,
                                )
                                // CustomText(
                                //   text: product.size,
                                // ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        _productsizes(product!.sizes!),
                        SizedBox(
                          height: 30,
                        ),
                        CustomText(
                          text: "Details",
                          fontSize: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomText(
                          text: product!.description.toString(),
                          maxLine: 10,
                          fontSize: 20,
                          color: Colors.grey[600]!,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CustomText(text: "Price", color: Colors.grey[400]!),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: "${product!.price} \$",
                      fontSize: 20,
                      color: primarycolor,
                    )
                  ],
                ),
                GetBuilder<CartController>(
                  init: Get.find<CartController>(),
                  builder: (CartController) => Container(
                    width: 150,
                    child: CustomButton(
                      text: "Add",
                      onPress: () async {
                        if (CartController.selectedSize != "") {
                          bool isAdded = await CartController.addProduct(
                              CartProduct(
                                  productId: product!.id,
                                  name: product!.name,
                                  image: product!.images!.first,
                                  price: product!.price,
                                  size: CartController.selectedSize,
                                  color: Colors.red,
                                  description: product!.description,
                                  quantity: 1));
                          if (!isAdded) {
                            myCustomSnackbar(
                                type: toastType.Success,
                                title: "You have successfully Added to card",
                                body: " product ID ${product!.id}");
                            //_onAlertWithCustomImagePressed(context);
                            // reset selected size to nothing if on click on product
                            CartController.onInitializeSize();
                          } else {
                            myCustomSnackbar(
                                duration: 2,
                                type: toastType.Warning,
                                title: "Warning",
                                body: "Already Added");
                            // Toast.show("Already Added",
                            //     duration: 2,
                            //     backgroundColor: Colors.red,
                            //     gravity: Toast.top);
                            CartController.onInitializeSize();
                          }
                        } else {
                          myCustomSnackbar(
                              type: toastType.Error,
                              title: "Error",
                              body: "Select size befor add to cart");
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onAlertWithCustomImagePressed(context) {
    var alertStyle = AlertStyle(animationDuration: Duration(milliseconds: 1));
    Alert(
      style: alertStyle,
      context: context,
      title: "Item Added to Cart",
      image: Image.asset("assets/images/success.png"),
      buttons: [
        DialogButton(
          child: Text(
            "Go To Cart",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Get.off(CartView()),
          width: 120,
        )
      ],
    ).show();
  }

  Widget _productsizes(List<String> sizes) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 8, // horizontal
        runSpacing: 8, // vertical
        children: List.generate(
          sizes.length,
          (index) => GetBuilder<CartController>(
            init: Get.find<CartController>(),
            builder: (cartController) => GestureDetector(
              onTap: () => cartController.onselectsize(sizes[index].toString()),
              child: Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  sizes[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade300,
                  border: cartController.selectedSize == sizes[index]
                      ? Border.all(color: primarycolor, width: 2)
                      : Border.all(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _images_of_product(BuildContext context, String image) => Container(
        width: double.infinity,
        child: image != ""
            ? Image.network(
                image,
                fit: BoxFit.cover,
              )
            : Image.asset(
                'assets/icons/chaire.png',
                fit: BoxFit.fill,
              ),
      );
}
