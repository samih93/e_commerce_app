import 'package:e_commerce_app/models/Category.dart';
import 'package:e_commerce_app/service/ApplicationDb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModelService extends GetxController {
  ValueNotifier<bool> _categoryIsLoding = ValueNotifier(false);
  ValueNotifier<bool> get categoryIsLoading => _categoryIsLoding;

  var _CategoryList = <Category>[];

  List<Category> get CategoryList => _CategoryList;

  HomeViewModelService() {
    getCategories();
  }

  getCategories() async {
    _categoryIsLoding.value = true;
    await ApplicationDb().getCategories().then((value) {
      for (int i = 0; i < value.length; i++) {
        _CategoryList.add(Category.fromjson(value[i].data()));
      }
      _categoryIsLoding.value = false;
      update();
    });
  }
}
