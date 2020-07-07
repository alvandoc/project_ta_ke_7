import 'package:project_ta_ke_7/core/database/database.dart';
import 'package:project_ta_ke_7/core/models/category_model.dart';
import 'package:project_ta_ke_7/core/models/produk_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductDB {
  var helper = DatabaseHelper();

  Future <int> create(ProdukModel produk) async {
    Database db = await helper.database;
    var result = db.insert("produk", produk.toMap());
    return result;
  }

  //* Mengambil Semua data dari tabel produk dan relasi category
  Future getAll() async {
    Database db = await helper.database;

    var result = await db.rawQuery('''SELECT p.id, p.title, p.stock, 
      p.description, p.price, p.image, c.id as category_id, c.icon as category_icon, 
      c.name as category FROM produk p 
      INNER JOIN category c ON p.category_id = c.id''');
    return result;
  }

  Future getProductById(String id) async {
    Database db = await helper.database;

    var result = await db.rawQuery('''SELECT p.id, p.title, p.stock, 
      p.description, p.price, p.image, c.id as category_id, c.icon as category_icon, 
      c.name as category FROM produk p 
      INNER JOIN category c ON p.category_id = c.id WHERE p.id = ${id}''');
    return result;
  }

  Future updateProdukStok(int produkID, int quantity) async {
    Database db = await helper.database;

    var result = await db.rawUpdate('''update produk set stock = ? WHERE id = ? ''', [quantity, produkID]);
    return result;
  }

  Future delete(String id) async {
    Database db = await helper.database;
    var result = await db.delete("produk", where: "id = ?", whereArgs: [id]);
    return result;
  }

  Future <int> update(ProdukModel produk, int id) async {
    Database db = await helper.database;

    var result = db.update("produk", produk.toMap(), where: 'id = ?', whereArgs: [id]);
    return result;
  }
}