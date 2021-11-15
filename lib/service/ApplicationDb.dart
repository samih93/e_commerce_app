import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/Category.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ApplicationDb extends GetxController {
  final CollectionReference _categoryCollectionRef =
      FirebaseFirestore.instance.collection('Categories');

  Future<List<QueryDocumentSnapshot>> getCategories() async {
    var value = await _categoryCollectionRef.get();
    return value.docs;
  }
}
