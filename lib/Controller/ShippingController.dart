import 'package:country_picker/country_picker.dart';
import 'package:e_commerce_app/models/Address.dart';
import 'package:e_commerce_app/service/sqflitedatabase/EcommerceDatabasehelper.dart';
import 'package:e_commerce_app/views/ShippingAddressView.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ShippingController extends GetxController {
  String firstname, lastname, address, state, city, country, phone, postcode;
  Address _addressmodel = null;
  Address get addressmodel => _addressmodel;
  List<Address> _list_of_address = [];
  List<Address> get list_of_address => _list_of_address;

  var countryTextEditingcontroller = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey();
  var dbHelper = EcommerceDatabasehelper.db;

  ShippingController() {
    getAddress();
  }
  insertAddress(Address addressmodel) async {
    if (_list_of_address.length == 0) {
      //to generate new id
      var uuid = Uuid();
      addressmodel.id = uuid.v1();
      ///////////

      await dbHelper.insertaddress(addressmodel);
      await getAddress();
      // Get.off(ControlView());
    } else {
      await dbHelper.updateaddress(addressmodel);
      await getAddress();
      print(_addressmodel.toJson());

      //Get.off(ControlView());
    }

    // print("from controller " + address.firstname);
    // Address address = getAddress();
    //if (address == null) await dbHelper.insertaddress(addressmodel);
  }

  Future getAddress() async {
    _list_of_address = await dbHelper.getAddress();
    _addressmodel = _list_of_address.length > 0 ? _list_of_address[0] : null;
    print("list of address lenght " + _list_of_address.length.toString());

    // to set controller initial value is cuurent country // cz i dont have permission to give textformfield initial value and then give controller to change country
    // only one of both
    countryTextEditingcontroller.text =
        _list_of_address.length > 0 ? _list_of_address[0].country : "";
    update();
  }
}
