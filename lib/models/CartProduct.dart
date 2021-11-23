// @dart=2.9

import 'dart:ffi';

import 'package:e_commerce_app/helper/extention.dart';
import 'package:flutter/material.dart';

class CartProduct {
  String name, image, price;
  int quantity;
  //Color color;

  CartProduct({this.name, this.image, this.price, this.quantity});

  CartProduct.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    name = map['name'];
    image = map['image'];
    price = map['price'].toString();
    quantity = int.parse(map['quantity'].toString());
    // cast bool fromjson to model
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity ?? 0,
    };
  }
}
