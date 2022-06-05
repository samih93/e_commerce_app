import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/Address.dart';
import 'package:e_commerce_app/models/CartProduct.dart';
import 'package:e_commerce_app/models/ordermodel.dart';
import 'package:e_commerce_app/shared/Constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    //getallOrder();
    super.onReady();
  }

  /// Add Order
  final databasereference = FirebaseFirestore.instance;
  bool isloadingPostOrder = false;
  bool isOrdersuccess = false;
  Future<String> addOrder(
      Address address, List<CartProduct> items, double totalprice) async {
    String orderid = "";
    isloadingPostOrder = true;
    update();

    var order = Order(
            totalprice: totalprice,
            uId: currentuserModel.userId,
            orderdate: Timestamp.now(),
            shippingAddress: address,
            personelInformation: currentuserModel,
            orderItems: items)
        .toJson();
    print("order----------------");
    print(order['orderItems']);

    await databasereference.collection('orders').add(order).then((value) async {
      //  add items collection
      orderid = value.id;
      isloadingPostOrder = false;
      isOrdersuccess = true;
      update();
    }).catchError((error) {
      print(error.toString());
    });

    return orderid;
  }

//get all orders

  List<CartProduct> myOrders = [];
  Future<void> getallOrder() async {
    myOrders = [];

    databasereference
        .collection('orders')
        .where('uId', isEqualTo: currentuserModel.userId)
        .get()
        .then((value) {
      if (value.docs.length > 0) {
        // myOrders.forEach((element) {
        //   print(element.toJson());
        // });
      }
    });
  }
}
