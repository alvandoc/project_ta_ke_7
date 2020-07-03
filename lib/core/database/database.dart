import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:project_ta_ke_7/core/models/category_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  // Instanse database
  Database _database;
  // Nama database
  String _dbName = "testing2553";

  // Membuat getter database
  Future<Database> get database async {
    // Jika database masih kosong
    // Maka akan init database baru
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  // inisisalisasi database
  Future<Database> initializeDatabase() async {
    // mengambil koleksi database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}/${_dbName}";

    // Membuka Database
    var database = await openDatabase(path, version: 1,onCreate: _createDB);
    return database;
  }

  // Fungtion Membuat database yang baru
  void _createDB (Database db, int newVersion) async {
    //* Creating produk table
    await db.execute('''CREATE TABLE produk (id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT, stock INTEGER, description TEXT, price INTEGER, image TEXT, category_id INTEGER, created_at DATETIME)''');

    //* Creating category table
    await db.execute('''CREATE TABLE category (id INTEGER PRIMARY KEY AUTOINCREMENT,
      icon INTEGER, name TEXT, created_at DATETIME)''');

    //* Creating default category
    await _createDefaultCategory(db);

    //* Creating barang_keluar table
    await db.execute('''CREATE TABLE barang_keluar (id INTEGER PRIMARY KEY AUTOINCREMENT,
      produk_id INTEGER, quantity INTEGER, created_at DATETIME)''');

    //* Creating barang_masuk table
    await db.execute('''CREATE TABLE barang_masuk (id INTEGER PRIMARY KEY AUTOINCREMENT,
      produk_id INTEGER, quantity INTEGER, vendor TEXT, created_at DATETIME)'''); 

    //* Creating user table
    await db.execute('''CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT, password TEXT, name TEXT, phone TEXT, email TEXT)''');
  }

  /// Creating default category
  void _createDefaultCategory(Database db) async {
    await db.insert("category", CategoryModel(
      icon: 58746,
      name: "Makanan",
      createdAt: DateTime.now()
    ).toMap());
    await db.insert("category", CategoryModel(
      icon: 58746,
      name: "Minuman",
      createdAt: DateTime.now()
    ).toMap());
  }

  
}

