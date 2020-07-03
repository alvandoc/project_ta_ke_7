import 'package:project_ta_ke_7/core/database/database.dart';
import 'package:project_ta_ke_7/core/models/auth_model.dart';
import 'package:sqflite/sqflite.dart';

class AuthDB {
  var helper = DatabaseHelper();

  Future <int> register(RegisterModel register) async {
    Database db = await helper.database;
    var result = db.insert("user", register.toMap());
    return result;
  }

  Future usernameExists(String username) async {
    Database db = await helper.database;

    var result = await db.query("user", where: "username = ?", whereArgs: [username]);
    return result;
  }

  Future getUser(String username) async {
    Database db = await helper.database;

    var result = await db.rawQuery("Select * from user where username = '$username'");
    return result[0];
  }

  Future usernameAndPasswordExists(String username, String password) async {
    Database db = await helper.database;
    var result = await db.query("user", where: "username = ? AND password = ?", whereArgs: [username, password]);
    return result;
  }

}