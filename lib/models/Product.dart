// @dart=2.9

import 'dart:convert';

import 'package:e_commerce_app/helper/extention.dart';
import 'package:flutter/material.dart';

class Product {
  String id, name, image, description, price;
  List<String> images;
  Color color;
  bool isfavorite = false;
  List<String> sizes;
  //Color color;

  Product(
      {this.id,
      this.name,
      this.images,
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
    List<String> listofimages = [];

    if (map['images'] != null) {
      map['images'].forEach((content) {
        listofimages.add(content);
      });
    } else {
      listofimages = null;
    }

    id = map["productId"];
    name = map["name"];
    image = map['image'];
    images = listofimages;
    description = map["description"];
    color = HexColor.fromHex(map["color"]);
    sizes = listOfsize;
    price = map["price"];
    isfavorite = map["isfavorite"];
  }

  toJson() {
    return {
      'productId': id,
      'name': name,
      'images': images,
      'description': description,
      'color': color,
      'size': sizes,
      'price': price,
      // cast bool
      'isfavorite': isfavorite ? 1 : 0,
    };
  }
}
