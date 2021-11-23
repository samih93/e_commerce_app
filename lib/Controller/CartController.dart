import 'dart:ui';

import 'package:e_commerce_app/models/CartProduct.dart';
import 'package:e_commerce_app/service/sqflitedatabase/CartDatabasehelper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CartController extends GetxController {
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  List<CartProduct> _cartproductList;

  List<CartProduct> get cardproductList => _cartproductList;

  double _totalPrice = 0.0;
  double get totalprice => _totalPrice;

  CartController() {
    getallproduct();
  }
  addProduct(CartProduct model) async {
    var dbHelper = CartDatabasehelper.db;
    if (_cartproductList.length > 0) {
      for (int i = 0; i < _cartproductList.length; i++) {
        if (_cartproductList[i].productId == model.productId) return;
      }
    }
    await dbHelper.insert(model);
    _cartproductList = await dbHelper.getallproduct();
    update();
  }

  getallproduct() async {
    _loading.value = true;
    var dbHelper = CartDatabasehelper.db;
    _cartproductList = await dbHelper.getallproduct();

    print("lenght ${_cartproductList.length ?? 0}");

    _loading.value = false;
    update();
  }

  Future<void> deleteproductfromdatbase(String ProductId) async {
    var dbHelper = CartDatabasehelper.db;
    await dbHelper.deleteProductFromdatabase(ProductId);
    _cartproductList = await dbHelper.getallproduct();
    print("deleted");
    update();
  }

  _getTotalPrice() {
    for (int i = 0; i < _cartproductList.length; i++) {
      _totalPrice += double.parse(_cartproductList[i].price) *
          double.parse(_cartproductList[i].quantity.toString());
    }
  }
}
