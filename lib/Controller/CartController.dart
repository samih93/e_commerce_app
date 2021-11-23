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

  CartController() {
    getallproduct();
  }
  addProduct(CartProduct model) async {
    var dbHelper = CartDatabasehelper.db;
    await dbHelper.insert(model);
    update();
  }

  getallproduct() async {
    _loading.value = true;
    var dbHelper = CartDatabasehelper.db;
    _cartproductList = await dbHelper.getallproduct();
    print(_cartproductList.length ?? 0);

    _loading.value = false;
    update();
  }
}
