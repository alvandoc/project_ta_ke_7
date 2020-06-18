import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  // Instanse database
  Database _database;
  // Nama database
  String _dbName = "Myinventory";

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
    await db.execute('''CREATE TABLE produk (id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT, jumlah INTEGER, deskripsi TEXT, harga DOUBLE, image TEXT)''');
  }

  
}

