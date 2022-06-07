import 'package:e_commerce_app/models/UserModel.dart';
import 'package:flutter/material.dart';

//const primarycolor = Color.fromRGBO(0, 197, 105, 1);
const primarycolor = Colors.teal;

const localUserData = "user";
UserModel? currentuserModel;

List<Color> primarygradient = <Color>[
  Colors.teal.shade900,
  Colors.teal.shade700,
  Colors.teal.shade400,
];
List<Color> disabledprimarygradient = <Color>[
  Colors.teal.shade500,
  Colors.teal.shade300,
  Colors.teal.shade100,
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

final String tablePayment = "payment";
final String columnpaymentId = "id";
final String columnCardNumber = "number";
final String columnCardExpiredDate = "expireddate";
final String columnCardCVV = "cvv";
final String columnCardHolderName = "name";
