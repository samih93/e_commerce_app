import 'package:e_commerce_app/Constant.dart';
import 'package:e_commerce_app/models/CartProduct.dart';
import 'package:e_commerce_app/models/Product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartDatabasehelper {
  // intsance wahad men hyda l class
  CartDatabasehelper._();

  static final CartDatabasehelper db = CartDatabasehelper._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), "CardProduct.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
      CREATE TABLE $tableCardProduct (
        $columnName TEXT NOT NULL ,
        $columnImage TEXT NOT NULL ,
        $columnQuantity TEXT NOT NULL ,
        $columnPrice INTEGER NOT NULL)
          ''');
    });
  }

  insert(CartProduct model) async {
    var dbclient = await database;
    await dbclient.insert(tableCardProduct, model.toJson());
  }

  Future<List<CartProduct>> getallproduct() async {
    var dbclient = await database;
    List<Map> maps = await dbclient.query(tableCardProduct);
    List<CartProduct> list = maps.isNotEmpty
        ? maps.map((Product) => CartProduct.fromJson(Product)).toList()
        : [];
  }
}
