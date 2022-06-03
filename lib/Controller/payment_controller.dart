import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/models/payment_model.dart';
import 'package:e_commerce_app/service/sqflitedatabase/EcommerceDatabasehelper.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:uuid/uuid.dart';

class PaymentController extends GetxController {
  String firstname, lastname, address, state, city, country, phone, postcode;

  var dbHelper = EcommerceDatabasehelper.db;

  PaymentController() {
    getPaymentMethod().then((value) {
      paymentModel = value;
      // print(value);
    });
  }

  PaymentModel paymentModel = null;

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

  Future<PaymentModel> updatePayment(PaymentModel model) async {
    var dbclient = await dbHelper.database;
    await dbclient.update(tablePayment, model.toJson(),
        where: '$columnpaymentId =?', whereArgs: [model.id]);
    print("Payment method Updated");
    return getPaymentMethod();
  }

  Future<PaymentModel> getPaymentMethod() async {
    var dbclient = await dbHelper.database;
    var payment_query = await dbclient.query(tablePayment, limit: 1);
    Map<String, dynamic> map = null;
    ;
    print("payment lenght " + payment_query.length.toString());

    if (payment_query.length > 0) map = payment_query.first;
    paymentModel = map != null ? PaymentModel.fromJson(map) : null;
    update();

    return paymentModel;
  }
}
