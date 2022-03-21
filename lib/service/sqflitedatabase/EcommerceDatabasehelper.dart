import 'dart:io';

import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/models/Address.dart';
import 'package:e_commerce_app/models/CartProduct.dart';
import 'package:e_commerce_app/models/favoriteProduct.dart';
import 'package:e_commerce_app/models/payment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class EcommerceDatabasehelper {
  // intsance wahad men hyda l class
  EcommerceDatabasehelper._();

  static final EcommerceDatabasehelper db = EcommerceDatabasehelper._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), "ECommerce.db");
    print(path);
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE $tableCardProduct (
        $columnName TEXT NOT NULL ,
        $columnImage TEXT NOT NULL ,
        $columnQuantity TEXT NOT NULL ,
        $columnproductId TEXT NOT NULL ,
        $columnSize TEXT NOT NULL ,
        $columnColor TEXT NOT NULL ,
        $columnDescription TEXT NOT NULL ,
        $columnPrice INTEGER NOT NULL)
          ''');
      await db.execute('''
      CREATE TABLE $tableFavoriteProduct (
        $columnfavoriteProductId TEXT NOT NULL,
        $columnName TEXT NOT NULL,
        $columnImage TEXT NOT NULL,
        $columnDescription TEXT NOT NULL,
        $columnPrice INTEGER NOT NULL,
        $columnisFavorite INTEGER NOT NULL
        )
          ''');

      await db.execute('''
      CREATE TABLE $tableAddress (
        $columnAddressId INTEGER NOT NULL,
        $columnfirstname TEXT NOT NULL,
        $columnlastname TEXT NOT NULL,
        $columnlocation TEXT NOT NULL,
        $columnstate TEXT NOT NULL,
        $columncity TEXT NOT NULL,
        $columnpostcode TEXT NOT NULL,
        $columncountry TEXT NOT NULL,
        $columnphone TEXT NOT NULL
        )
          ''');

      await db.execute('''
      CREATE TABLE $tablePayment (
        $columnpaymentId INTEGER NOT NULL,
        $columnCardNumber TEXT NOT NULL,
        $columnCardExpiredDate TEXT NOT NULL,
        $columnCardCVV TEXT NOT NULL,
        $columnCardHolderName TEXT NOT NULL
       
        )
          ''');
    });
  }

  Future<List<CartProduct>> getallproduct() async {
    var dbclient = await database;
    List<Map> maps = await dbclient.query(tableCardProduct);
    List<CartProduct> list = maps.isNotEmpty
        ? maps.map((Product) => CartProduct.fromJson(Product)).toList()
        : [];
    list.forEach((element) {
      print(element.productId);
    });
    return list;
  }

  insertcartproduct(CartProduct model) async {
    var dbclient = await database;
    await dbclient.insert(tableCardProduct, model.toJson());
    //  print("model.json " + model.toJson());
  }

  insertPayment(PaymentModel model) async {
    var dbclient = await database;
    await dbclient.insert(tablePayment, model.toJson());
    //  print("model.json " + model.toJson());
  }

  updateProductQuatity({String productId, int quatity}) async {
    var dbclient = await database;
    await dbclient.rawDelete(
        "UPDATE  $tableCardProduct SET $columnQuantity= $quatity where  $columnproductId='$productId'");
    print("Updated");
  }

  updatecartProduct(CartProduct model) async {
    var dbclient = await database;
    await dbclient.update(tableCardProduct, model.toJson(),
        where: '$columnproductId =?', whereArgs: [model.productId]);
    print("Updated");
  }

  deletecartproduct(String productId) async {
    var dbclient = await database;
    await dbclient.rawDelete(
        "DELETE FROM $tableCardProduct WHERE $columnproductId='$productId'");
    print("Deleted");
  }

  // add product favorite to sqllite
  Future<List<favoriteProduct>> addfavoriteproduct(
      favoriteProduct model) async {
    var dbclient = await database;
    await dbclient.insert(tableFavoriteProduct, model.toJson());
    print("Product Added to favorite");
    return getallfavoriteproducts();
  }

  Future<List<favoriteProduct>> updatefavoriteProduct(
      favoriteProduct model) async {
    var dbclient = await database;
    await dbclient.update(tableFavoriteProduct, model.toJson(),
        where: '$columnfavoriteProductId =?', whereArgs: [model.product.id]);
    print("Updated successfully");
    return getallfavoriteproducts();
  }

  Future<List<favoriteProduct>> getallfavoriteproducts() async {
    var dbclient = await database;
    List<Map> maps = await dbclient.query(tableFavoriteProduct);
    // maps.forEach((element) {
    //   print(element);
    // });
    List<favoriteProduct> list = maps.isNotEmpty
        ? maps
            .map((favproduct) => favoriteProduct.fromJson(favproduct))
            .toList()
        : [];
    // list.forEach((element) {
    //   print("get favprod   ---" +
    //       element.productId +
    //       " : " +
    //       element.isfavorite.toString());
    // });
    return list;
  }

  insertaddress(Address model) async {
    var dbclient = await database;
    await dbclient.insert(tableAddress, model.toJson());
    print("Address inserted");
  }

  Future<List<Address>> updateaddress(Address model) async {
    var dbclient = await database;
    await dbclient.update(tableAddress, model.toJson(),
        where: '$columnAddressId =?', whereArgs: [model.id]);
    print("Address Updated");
    return getAddress();
  }

  Future<List<Address>> getAddress() async {
    var dbclient = await database;
    List<Map> maps = await dbclient.query(tableAddress, limit: 1);
    List<Address> list_address = maps.isNotEmpty
        ? maps.map((add_data) => Address.fromJson(add_data)).toList()
        : [];

    // address.forEach((element) {
    //   print("from database helper " + element.firstname);
    // });

    return list_address;
    //print("from get address" + address.firstname);
  }
}
