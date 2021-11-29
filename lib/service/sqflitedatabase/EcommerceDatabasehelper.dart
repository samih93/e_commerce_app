import 'dart:io';

import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/models/CartProduct.dart';
import 'package:e_commerce_app/models/favoriteProduct.dart';
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

  insert(CartProduct model) async {
    var dbclient = await database;
    await dbclient.insert(tableCardProduct, model.toJson());
    //  print("model.json " + model.toJson());
  }

  updateProductQuatity({String productId, int quatity}) async {
    var dbclient = await database;
    await dbclient.rawDelete(
        "UPDATE  $tableCardProduct SET $columnQuantity= $quatity where  $columnproductId='$productId'");
    print("Updated");
  }

  updateProduct(CartProduct model) async {
    var dbclient = await database;
    await dbclient.update(tableCardProduct, model.toJson(),
        where: '$columnproductId =?', whereArgs: [model.productId]);
    print("Updated");
  }

  delete(String productId) async {
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
    maps.forEach((element) {
      print(element);
    });
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
}
