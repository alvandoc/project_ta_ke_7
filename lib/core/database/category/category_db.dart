

import 'package:project_ta_ke_7/core/database/database.dart';
import 'package:project_ta_ke_7/core/models/category_model.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDB {
  var helper = DatabaseHelper();

  Future <int> create(CategoryModel category) async {
    Database db = await helper.database;
    var result = db.insert("category", category.toMap());
    return result;
  }

  Future getAll() async {
    Database db = await helper.database;

    // Mengambil Semua data dari tabel category
    var result = await db.query("category");
    return result;
  }

  Future delete(String id) async {
    Database db = await helper.database;
    var result = await db.delete("category", where: "id = ?", whereArgs: [id]);
    return result;
  }
}