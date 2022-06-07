import 'dart:ui';

import 'package:e_commerce_app/models/CartProduct.dart';
import 'package:e_commerce_app/models/Product.dart';
import 'package:e_commerce_app/models/favoriteProduct.dart';
import 'package:e_commerce_app/service/ApplicationDb.dart';
import 'package:e_commerce_app/service/sqflitedatabase/EcommerceDatabasehelper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CartController extends GetxController {
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  List<CartProduct> _cartproductList = [];

  List<CartProduct> get cartproductList => _cartproductList;

  List<CartProduct> get cartcheckOutList =>
      _cartproductList.where((element) => element.ischecked == true).toList();

  double get totalprice => _getTotalPrice();

  var dbHelper = EcommerceDatabasehelper.db;

  String _selectedSize = "";
  String get selectedSize => _selectedSize;

  //List<String> _listOfSizesOfproduct = [];

  CartController() {
    getallproduct();
  }

  onselectsize(String size) {
    _selectedSize = size;
    update();
  }

  onInitializeSize() {
    _selectedSize = "";
    update();
  }

  List<String> getSizesOfProduct(String productId) {
    List<Product> ProductList = <Product>[];
    List<String> sizes = <String>[];

    ApplicationDb().getProducts().then((value) {
      for (int i = 0; i < value.length; i++) {
        //print(value[i].data());
        ProductList.add(
            Product.fromJson(value[i].data() as Map<dynamic, dynamic>));
      }
      ProductList.forEach((element) {
        if (element.id == productId) {
          sizes = element.sizes!;
        }
      });
    });
    return sizes;
  }

  getallproduct() async {
    _loading.value = true;
    dbHelper = EcommerceDatabasehelper.db;
    _cartproductList = await dbHelper.getallproduct();

    print("lenght of all products ${_cartproductList.length}");

    _loading.value = false;
    update();
  }

  double _getTotalPrice() {
    double finalprice = 0.0;
    if (_cartproductList.length > 0) {
      for (int i = 0; i < _cartproductList.length; i++) {
        if (_cartproductList[i].ischecked!) {
          finalprice += double.parse(_cartproductList[i].price.toString()) *
              double.parse(_cartproductList[i].quantity.toString());
        }
      }
    }
    return finalprice;
  }

  Future<void> increase_decrease_quatity(
      String productId, bool isIncrease) async {
    CartProduct? product;
    cartproductList.forEach((element) {
      if (element.productId == productId) {
        product = element;
        if (isIncrease) {
          element.quantity = element.quantity! + 1;
        } else {
          if (element.quantity! > 1) element.quantity = element.quantity! - 1;
        }
        dbHelper.updatecartProduct(product!);
        update();
      }
    });
  }

  Future<bool> addProduct(CartProduct model) async {
    dbHelper = EcommerceDatabasehelper.db;
    if (_cartproductList.length > 0) {
      for (int i = 0; i < _cartproductList.length; i++) {
        if (_cartproductList[i].productId == model.productId) return true;
      }
    }
    await dbHelper.insertcartproduct(model);
    _cartproductList = await dbHelper.getallproduct();
    update();
    return false;
  }

  Future<void> updateProductQuatity(String productId, int quantity) async {
    dbHelper = EcommerceDatabasehelper.db;
    await dbHelper.updateProductQuatity(
        quatity: quantity, productId: productId);
    print("Updated");
  }

  Future<void> deleteproduct(String ProductId) async {
    dbHelper = EcommerceDatabasehelper.db;
    await dbHelper.deletecartproduct(ProductId);
    _cartproductList = await dbHelper.getallproduct();
    //  print("deleted");
    update();
  }

// onchage checkbox in cart view
  onchangeCheckbox(index, value) {
    _cartproductList[index].ischecked = value;
    update();
  }

  void clearBasket() {
    _cartproductList.clear();
    update();
  }

  Future<void> deleteAllcartItems() async {
    dbHelper = EcommerceDatabasehelper.db;
    await dbHelper.deleteAllcartproducts();
    clearBasket();
  }

  clearChekoutListFromBasket() async {
    var toremove = [];
    List<String> ids = [];
    cartproductList.forEach((element) {
      if (element.ischecked!) {
        toremove.add(element);
        ids.add(element.productId!);
      }
    });
    cartproductList.removeWhere((element) => toremove.contains(element));
    ids.forEach((element) {
      print("deleted id :" + element);
    });
    update();
    await dbHelper.deletecartproductbyIds(ids);
  }
}
