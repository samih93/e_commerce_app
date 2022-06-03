import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Controller/ProfileController.dart';
import 'package:e_commerce_app/models/Address.dart';
import 'package:e_commerce_app/models/CartProduct.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    //getallOrder();
    super.onReady();
  }

  ProfileController profileController = Get.put(ProfileController());

  /// Add Order
  final databasereference = FirebaseFirestore.instance;
  bool isloadingPostOrder = false;
  bool isOrdersuccess = false;
  Future<String> addOrder(
      Address address, List<CartProduct> items, double totalprice) async {
    String orderid = "";
    isloadingPostOrder = true;
    update();
    var batch = databasereference.batch();
    await databasereference.collection('orders').add({
      'totalprice': totalprice,
      "uId": profileController.userModel.userId,
      "shippingAddress": address.toJson(),
      "personelInformation": profileController.userModel.tojson(),
    }).then((value) async {
      //  add items collection
      orderid = value.id;
      items.forEach((element) {
        batch.set(
            databasereference
                .collection('orders')
                .doc(value.id)
                .collection('orderItems')
                .doc(element.productId),
            element.toJson());
      });
      await batch.commit();

      print('order id :' + value.id);
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
        .where('uId', isEqualTo: profileController.userModel.userId)
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
