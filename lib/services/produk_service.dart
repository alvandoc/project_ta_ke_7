import 'package:project_ta_ke_7/database/prod_db.dart';
import 'package:project_ta_ke_7/models/produk_mdl.dart';

class ProdukServices {
  // instance Database
  static ProdDB _prodDB;

  // Fungsi Untuk Mendapatkan Semua Produk
  static Future<List<ProdModel>> getAll() async {
    _prodDB = new ProdDB();

    var _result = await _prodDB.getAll();
    var data = new List<ProdModel>();
    _result.forEach((produk) {
      data.add(ProdModel.fromMap(produk));
    });

    return data;
  }

  static Future<bool> create(ProdModel prodModel) async {
    _prodDB = new ProdDB();

    var _result = await _prodDB.create(prodModel);
    if (_result != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> delete(ProdModel prodModel) async {
    _prodDB = new ProdDB();

    var _result = await _prodDB.delete(prodModel.id);
    if (_result != null) {
      return true;
    } else {
      return false;
    }
  }

  static update(ProdModel prodModel, String id) async {
    _prodDB = new ProdDB();

    var _result = await _prodDB.update(prodModel, int.parse(id));
    if (_result != null) {
      return true;
    } else {
      return false;
    }
  }
}
