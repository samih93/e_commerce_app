// @dart=2.9

import 'dart:convert';
import 'dart:ffi';

import 'package:e_commerce_app/helper/extention.dart';
import 'package:flutter/material.dart';

class Product {
  String id, name, image, description, price;
  Color color;
  bool isfavorite = false;
  List<String> sizes;
  //Color color;

  Product(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.color,
      this.sizes,
      this.price,
      this.isfavorite});

  Product.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    List<String> listOfsize = [];
    if (map['size'] != null) {
      map['size'].forEach((content) {
        listOfsize.add(content);
      });
    } else {
      listOfsize = null;
    }
    id = map['productId'];
    name = map['name'];
    image = map['image'];
    description = map['description'];
    color = HexColor.fromHex(map['color']);
    sizes = listOfsize;
    price = map['price'];
    // cast bool fromjson to model
    isfavorite = map['isfavorite'];
  }

  toJson() {
    return {
      'productId': id,
      'name': name,
      'image': image,
      'description': description,
      'color': color,
      'size': sizes,
      'price': price,
      'isfavorite': isfavorite ? 1 : 0,
    };
  }
}
