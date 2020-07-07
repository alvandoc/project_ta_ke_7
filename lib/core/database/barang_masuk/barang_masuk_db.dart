import 'package:project_ta_ke_7/core/database/database.dart';
import 'package:project_ta_ke_7/core/models/barang_masuk_model.dart';
import 'package:project_ta_ke_7/core/models/category_model.dart';
import 'package:project_ta_ke_7/core/models/produk_model.dart';
import 'package:sqflite/sqflite.dart';

class BarangMasukDB {
  var helper = DatabaseHelper();

  Future <int> create(BarangMasukRequest barangMasuk) async {
    Database db = await helper.database;
    var result = db.insert("barang_masuk", barangMasuk.toMap());
    return result;
  }

  Future getAll() async {
    Database db = await helper.database;

    var result = await db.rawQuery('''SELECT bm.id, p.id as produk_id, p.title, p.stock, 
      p.description, p.price, p.image, c.id as category_id, c.icon as category_icon, 
      c.name as category, bm.quantity as quantity, bm.vendor as vendor FROM produk p 
      INNER JOIN barang_masuk bm ON bm.produk_id = p.id
      INNER JOIN category c ON p.category_id = c.id''');
    return result;
  }

  Future getTotalQuantity() async {
    Database db = await helper.database;

    var result = await db.rawQuery("SELECT sum(quantity) as total FROM barang_masuk");
    return result;
  }

  Future delete(String id) async {
    Database db = await helper.database;
    var result = await db.delete("barang_masuk", where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future deleteByProductID(String produkID) async {
    Database db = await helper.database;
    var result = await db.delete("barang_masuk", where: 'produk_id = ?', whereArgs: [produkID]);
    return result;
  }
}