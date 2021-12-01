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
        ProductList.add(Product.fromJson(value[i].data()));
      }
      ProductList.forEach((element) {
        if (element.id == productId) {
          sizes = element.sizes;
        }
      });
    });
    return sizes;
  }

  getallproduct() async {
    _loading.value = true;
    dbHelper = EcommerceDatabasehelper.db;
    _cartproductList = await dbHelper.getallproduct();

    print("lenght ${_cartproductList.length ?? 0}");

    _loading.value = false;
    update();
  }

  double _getTotalPrice() {
    double finalprice = 0.0;
    if (_cartproductList.length > 0) {
      for (int i = 0; i < _cartproductList.length; i++) {
        if (_cartproductList[i].ischecked) {
          finalprice += double.parse(_cartproductList[i].price) *
              double.parse(_cartproductList[i].quantity.toString());
        }
      }
    }
    return finalprice;
  }

  Future<void> increase_decrease_quatity(int index, bool isIncrease) {
    if (isIncrease) {
      _cartproductList[index].quantity++;
    } else {
      if (_cartproductList[index].quantity > 1)
        _cartproductList[index].quantity--;
    }
    // updateProduct(
    //     _cartproductList[index].productId, _cartproductList[index].quantity);
    dbHelper.updatecartProduct(_cartproductList[index]);
    update();
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
}
