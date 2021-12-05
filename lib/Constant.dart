import 'package:flutter/material.dart';

//const primarycolor = Color.fromRGBO(0, 197, 105, 1);
const primarycolor = Colors.teal;

const localUserData = "user";

List<Color> primarygradient = <Color>[
  Colors.teal.shade900,
  Colors.teal.shade700,
  Colors.teal.shade400,
];

// cart Product model

final String tableCardProduct = "cardproduct";

final String columnName = 'name';
final String columnImage = 'image';
final String columnPrice = 'price';
final String columnSize = 'size';
final String columnColor = 'color';
final String columnQuantity = 'quantity';
final String columnproductId = 'productId';
final String columnDescription = 'description';

// favorite product
final String tableFavoriteProduct = "favoriteProduct";
final String columnfavoriteProductId = "productId";
final String columnisFavorite = "isFavorite";

//Address
final String tableAddress = "address";
final String columnAddressId = "id";
final String columnfirstname = "firstname";
final String columnlastname = "lastname";
final String columnlocation = "location";
final String columnstate = "state";
final String columncity = "city";
final String columnpostcode = "postcode";
final String columncountry = "country";
final String columnphone = "phone";
