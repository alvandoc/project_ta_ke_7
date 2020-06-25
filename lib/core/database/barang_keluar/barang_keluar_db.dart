

import 'package:project_ta_ke_7/core/database/database.dart';
import 'package:project_ta_ke_7/core/models/barang_keluar_model.dart';
import 'package:project_ta_ke_7/core/models/category_model.dart';
import 'package:sqflite/sqflite.dart';

class BarangKeluarDB {
  var helper = DatabaseHelper();

  Future <int> create(BarangKeluarRequest barangKeluar) async {
    Database db = await helper.database;
    var result = db.insert("barang_keluar", barangKeluar.toMap());
    return result;
  }

  Future getAll() async {
    Database db = await helper.database;

    var result = await db.rawQuery('''SELECT bk.id, p.id as produk_id, p.title, p.stock, 
      p.description, p.price, p.image, c.id as category_id, c.icon as category_icon, 
      c.name as category, bk.quantity as quantity FROM produk p 
      INNER JOIN barang_keluar bk ON bk.produk_id = p.id
      INNER JOIN category c ON p.category_id = c.id''');
    return result;
  }

  Future getTotalQuantity() async {
    Database db = await helper.database;

    var result = await db.rawQuery("SELECT sum(quantity) as total FROM barang_keluar");
    return result;
  }

  Future delete(String id) async {
    Database db = await helper.database;
    var result = await db.delete("barang_keluar", where: "id = ?", whereArgs: [id]);
    return result;
  }

}