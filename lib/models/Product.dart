// @dart=2.9

import 'package:e_commerce_app/helper/extention.dart';
import 'package:flutter/material.dart';

class Product {
  String id, name, image, description, size, price;
  Color color;
  bool isfavorite;
  //Color color;

  Product(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.color,
      this.size,
      this.price,
      this.isfavorite});

  Product.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    id = map['docId'];
    name = map['name'];
    image = map['image'];
    description = map['description'];
    color = HexColor.fromHex(map['color']);
    size = map['size'];
    price = map['price'];
    // cast bool fromjson to model
    isfavorite = map['isfavorite'];
  }

  toJson() {
    return {
      'docId': id,
      'name': name,
      'image': image,
      'description': description,
      'color': color,
      'size': size,
      'price': price,
      'isfavorite': isfavorite ? 1 : 0,
    };
  }
}
