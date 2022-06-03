// @dart=2.9

import 'package:e_commerce_app/helper/extention.dart';
import 'package:flutter/material.dart';

class CartProduct {
  String name, image, price, productId, description, size;
  //ToDo : isfavorite
  int quantity;
  bool ischecked = false;
  Color color;

  //Color color;

  CartProduct(
      {this.productId,
      this.name,
      this.image,
      this.price,
      this.quantity,
      this.description,
      this.size,
      this.color});

  CartProduct.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    productId = map['productId'];
    name = map['name'];
    image = map['image'];
    description = map['description'];
    price = map['price'].toString();
    color = map['color'] != null ? HexColor.fromHex(map['color']) : null;
    size = map['size'];
    quantity = int.parse(map['quantity'].toString());

    // cast bool fromjson to model
  }

  toJson() {
    return {
      'productId': productId,
      'name': name,
      'image': image,
      'description': description,
      'price': price,
      'color': color.toHex(),
      'size': size,
      'quantity': quantity ?? 0,
    };
  }
}
