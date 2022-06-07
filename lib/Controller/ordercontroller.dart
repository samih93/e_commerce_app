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
    getallOrder();
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
            uId: currentuserModel!.userId,
            orderdate: Timestamp.now(),
            status: "Pending",
            shippingAddress: address,
            personelInformation: currentuserModel!,
            orderItems: items)
        .toJson();
    print("order----------------");
    print(order['orderItems']);

    await databasereference.collection('orders').add(order).then((value) async {
      //  add items collection
      orderid = value.id;
      await databasereference
          .collection('orders')
          .doc(orderid)
          .update({"orderId": orderid}).then((value) {
        isloadingPostOrder = false;
        isOrdersuccess = true;
        update();
        getallOrder();
      });
    }).catchError((error) {
      print(error.toString());
    });

    return orderid;
  }

//get all orders

  List<Order> myOrders = [];
  Future<void> getallOrder() async {
    myOrders = [];

    databasereference
        .collection('orders')
        .orderBy('orderdate', descending: true)
        .where('uId', isEqualTo: currentuserModel?.userId)
        .get()
        .then((value) {
      if (value.docs.length > 0) {
        // print("orders :" + value.docs.length.toString());
        value.docs.forEach((element) {
          print(element.data());
          myOrders.add(Order.fromJson(element.data()));
        });
      }
      myOrders.forEach((element) {
        print(element.toJson());
      });
    });
  }
}
