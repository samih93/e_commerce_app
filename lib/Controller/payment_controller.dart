import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/models/payment_model.dart';
import 'package:e_commerce_app/service/sqflitedatabase/EcommerceDatabasehelper.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:uuid/uuid.dart';

class PaymentController extends GetxController {
  String firstname, lastname, address, state, city, country, phone, postcode;

  var dbHelper = EcommerceDatabasehelper.db;
  PaymentModel paymentModel;

  PaymentController() {
    getPaymentMethod().then((value) {
      paymentModel = value;
      update();
    });
  }

  Future insertPaymentCard(PaymentModel model) async {
    await insertPayment(model);
  }

  void insertPayment(PaymentModel model) async {
    var uuid = Uuid();
    model.id = uuid.v1();
    var dbclient = await dbHelper.database;
    await dbclient.insert(tablePayment, model.toJson());
    //  print("model.json " + model.toJson());
  }

  Future<PaymentModel> updateaddress(PaymentModel model) async {
    var dbclient = await dbHelper.database;
    await dbclient.update(tablePayment, model.toJson(),
        where: '$columnAddressId =?', whereArgs: [model.id]);
    print("Payment method Updated");
    return getPaymentMethod();
  }

  Future<PaymentModel> getPaymentMethod() async {
    var dbclient = await dbHelper.database;
    var payment_query = await dbclient.query(tablePayment, limit: 1);

    Map<String, dynamic> map = payment_query.first;

    return PaymentModel.fromJson(map);
    //print("from get address" + address.firstname);
  }
}
