import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/Address.dart';
import 'package:e_commerce_app/models/CartProduct.dart';
import 'package:e_commerce_app/models/UserModel.dart';

class Order {
  double? totalprice;
  String? uId;
  Timestamp? orderdate;
  Address? shippingAddress; // Address
  UserModel? personelInformation; // userModel
  List<CartProduct>? orderItems;

  Order(
      {this.totalprice,
      this.uId,
      this.orderdate,
      this.shippingAddress,
      this.personelInformation,
      this.orderItems});

  Order.fromJson(Map<String, dynamic> map) {
    List<CartProduct> list_of_cart = [];

    totalprice =
        map["totalprice"] != null ? double.parse(map["totalprice"]) : 0;
    uId = map["uId"] != null ? map["uId"].toString() : '';
    orderdate = map["orderdate"] != null ? map["orderdate"] : Timestamp.now();
    shippingAddress = Address.fromJson(map['shippingAddress']);
    personelInformation = UserModel.fromjson(map['personelInformation']);
    map["orderItems"].forEach((element) {
      list_of_cart.add(CartProduct.fromJson(element));
    });
  }

  toJson() {
    return {
      "totalprice": totalprice,
      "uId": uId,
      "orderdate": orderdate,
      "shippingAddress": shippingAddress?.toJson(),
      "personelInformation": personelInformation?.tojson(),
      "orderItems": [
        ...orderItems!.map(
          (e) => e.toJson(),
        ),
      ]
    };
  }
}
