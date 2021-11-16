import 'package:e_commerce_app/helper/extention.dart';
import 'package:flutter/material.dart';

class Product {
  String name, image, description, size, price;
  Color color;
  //Color color;

  Product(
      {this.name,
      this.image,
      this.description,
      this.color,
      this.size,
      this.price});

  Product.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    name = map['name'];
    image = map['image'];
    description = map['description'];
    color = HexColor.fromHex(map['color']);
    size = map['size'];
    price = map['price'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'color': color,
      'size': size,
      'price': price,
    };
  }
}
