import 'package:sqflite/sqflite.dart';
import 'package:project_ta_ke_7/models/produk_mdl.dart';
import 'package:project_ta_ke_7/database/database.dart';

class ProdDB {
  // Membuat Instance database Helper
  DatabaseHelper helper = new DatabaseHelper();

  // Fungsi Mendapatkan Produk
  Future getAll() async {
    Database db = await helper.database;

  // Mengambil Semua data dari tabel produk
  var result = await db.query("produk");
  return result;
  }
  // Menambahkan sebuah data ke database ( Tabel Produk )
  Future <int> create(ProdModel prodModel) async {
    Database db = await helper.database;
    var result = db.insert("produk", prodModel.toMap());
    return result;
  }

  Future <int> update(ProdModel prodModel, int id) async {
    Database db = await helper.database;
    var result = db.update("produk", prodModel.toMap(), where: 'id = ?', whereArgs: [id]);
  return result;
  }

  Future calculateTotal() async {
  Database db = await helper.database;
  var result = await db.rawQuery("SELECT SUM(harga) as Total FROM produk");
  print(result.toList());
  }
  
  Future delete(String id) async {
    Database db = await helper.database;
    var result = await db.rawDelete("DELETE FROM produk where id=$id");
    return result;
  }
}

