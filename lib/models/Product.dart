import 'package:flutter/material.dart';

class Product {
  String name, image, description, sized, price, color;
  //Color color;

  Product(
      {this.name,
      this.image,
      this.description,
      this.color,
      this.sized,
      this.price});

  Product.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    name = map['name'];
    image = map['image'];
    description = map['description'];
    color = map['color'];
    // color = HexColor.fromHex(map['color']);
    sized = map['size'];
    price = map['price'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'color': color,
      'size': sized,
      'price': price,
    };
  }
}
