import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  // Instanse database
  Database _database;
  // Nama database
  String _dbName = "testing2";

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

    //* Creating barang_keluar table
    await db.execute('''CREATE TABLE barang_keluar (id INTEGER PRIMARY KEY AUTOINCREMENT,
      produk_id INTEGER, quantity INTEGER, created_at DATETIME)''');

    //* Creating barang_masuk table
    await db.execute('''CREATE TABLE barang_masuk (id INTEGER PRIMARY KEY AUTOINCREMENT,
      produk_id INTEGER, quantity INTEGER, vendor TEXT, created_at DATETIME)'''); 
  }

  
}

