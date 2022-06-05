import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  double totalprice;
  String uId;
  Timestamp orderdate;
  Map<String, dynamic> shippingAddress;
  Map<String, dynamic> personelInformation;
  List<Map<String, dynamic>> orderItems;
}
