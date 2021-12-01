import 'package:country_picker/country_picker.dart';
import 'package:e_commerce_app/models/Address.dart';
import 'package:e_commerce_app/service/sqflitedatabase/EcommerceDatabasehelper.dart';
import 'package:e_commerce_app/views/ShippingAddressView.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ShippingController extends GetxController {
  String firstname, lastname, address, state, city, country, phone, postcode;

  var countryTextEditingcontroller = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey();
  var dbHelper = EcommerceDatabasehelper.db;

  ShippingAddress() {
    //.address = Address();
    // getAddress();
  }

  insertAddress(Address addressmodel) async {
    await dbHelper.insertaddress(addressmodel);
    update();
  }

  getAddress() async {
    await dbHelper.getAddress();
    update();
  }
}
