import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/Category.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ApplicationDb extends GetxController {
  final CollectionReference _categoryCollectionRef =
      FirebaseFirestore.instance.collection('Categories');
  final CollectionReference _productCollectionRef =
      FirebaseFirestore.instance.collection('Products');

  Future<List<QueryDocumentSnapshot>> getCategories() async {
    var value = await _categoryCollectionRef.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getProducts() async {
    var value = await _productCollectionRef.get();
    return value.docs;
  }

//ToDo:
  // Future<List<QueryDocumentSnapshot>> getProductsBycategoryId() async {
  //   var value = await _productCollectionRef.get();
  //   return value.docs;
  // }

  // Future<void> ReadAllproductName(String docId) async {
  //   await _productCollectionRef.get().then((QuerySnapshot querysnapshot) {
  //     querysnapshot.docs.forEach((doc) {
  //       print(doc['name']);
  //     });
  //   });
  // }

  Future<void> setFavoriteProduct(String docId, bool isfavorite) {
    return _productCollectionRef
        .doc(docId)
        .update({'isfavorite': isfavorite})
        .then((value) => print("product Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
