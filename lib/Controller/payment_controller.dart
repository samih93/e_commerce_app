import 'package:e_commerce_app/shared/Constant.dart';
import 'package:e_commerce_app/models/payment_model.dart';
import 'package:e_commerce_app/service/sqflitedatabase/EcommerceDatabasehelper.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:uuid/uuid.dart';

class PaymentController extends GetxController {
  String? firstname, lastname, address, state, city, country, phone, postcode;

  var dbHelper = EcommerceDatabasehelper.db;

  PaymentController() {
    getPaymentMethod();
  }

  PaymentModel? paymentModel;

  Future insertPaymentCard(PaymentModel model) async {
    var uuid = Uuid();
    model.id = uuid.v1();
    //print(model.toJson());
    var dbclient = await dbHelper.database;
    await dbclient.insert(tablePayment, model.toJson()).then((value) {
      print("inseted");
    }).catchError((error) {
      print(error.toString());
    });
    await getPaymentMethod();
    //  print("model.json " + model.toJson());
    // await getPaymentMethod().then((value) {
    //   print(paymentModel.toJson());
    // });
  }

  Future<PaymentModel?> updatePayment(PaymentModel model) async {
    var dbclient = await dbHelper.database;
    await dbclient.update(tablePayment, model.toJson(),
        where: '$columnpaymentId =?', whereArgs: [model.id]);
    print("Payment method Updated");
    return await getPaymentMethod();
  }

  Future<PaymentModel?> getPaymentMethod() async {
    var _list_of_payment = await dbHelper.getPaymentMethod();
    paymentModel = _list_of_payment.length > 0 ? _list_of_payment[0] : null;
    update();
    print("list of payment lenght " + _list_of_payment.length.toString());
    return paymentModel;
  }
}
