
import 'package:project_ta_ke_7/core/database/barang_masuk/barang_masuk_db.dart';
import 'package:project_ta_ke_7/core/database/product/product_db.dart';
import 'package:project_ta_ke_7/core/models/barang_masuk_model.dart';
import 'package:project_ta_ke_7/core/models/produk_model.dart';

class BarangMasukService {

  static var barangMasukDB = new BarangMasukDB();
  static var produkDB = new ProductDB();

  Future<bool> create(BarangMasukRequest barangMasuk, int lastStock) async {
    var _result = await barangMasukDB.create(barangMasuk);
    await produkDB.updateProdukStok(lastStock);

    return _result != null ? true : false;
  }

  Future<List<BarangMasukModel>> getAll() async {
    var _result = await barangMasukDB.getAll();

    var data = new List<BarangMasukModel>();
    _result.forEach((barang) {
      data.add(BarangMasukModel.fromJson(barang));
    });

    return data;
  }

  Future<int> getTotalQuantity() async {
    var _result = await barangMasukDB.getTotalQuantity();
    return _result[0]["total"];
  }

  Future<bool> delete(String id, int lastStock) async {
    var _result = await barangMasukDB.delete(id);
    await produkDB.updateProdukStok(lastStock);

    return _result != null ? true : false;
  }


}