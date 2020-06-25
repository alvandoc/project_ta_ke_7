
import 'package:project_ta_ke_7/core/database/product/product_db.dart';
import 'package:project_ta_ke_7/core/models/produk_model.dart';

class ProductServices {

  static var produkDB = new ProductDB();

  Future<bool> create(ProdukModel produk) async {
    var _result = await produkDB.create(produk);
    return _result != null ? true : false;
  }

  Future<bool> delete(String id) async {
    var _result = await produkDB.delete(id);
    return _result != null ? true : false;
  }

  Future<bool> update(ProdukModel produk, int id) async {
    var _result = await produkDB.update(produk, id);
    return _result != null ? true : false;
  }

  Future<List<ProdukModel>> getAll() async {
    var _result = await produkDB.getAll();

    var data = new List<ProdukModel>();
    _result.forEach((produk) {
      data.add(ProdukModel.fromJson(produk));
    });

    return data;
  }

  Future<ProdukModel> getProductById(String id) async {
    var _result = await produkDB.getProductById(id);
    return ProdukModel.fromJson(_result[0]);
  }

}