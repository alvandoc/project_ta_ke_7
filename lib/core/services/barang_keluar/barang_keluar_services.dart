
import 'package:project_ta_ke_7/core/database/barang_keluar/barang_keluar_db.dart';
import 'package:project_ta_ke_7/core/database/category/category_db.dart';
import 'package:project_ta_ke_7/core/database/product/product_db.dart';
import 'package:project_ta_ke_7/core/models/barang_keluar_model.dart';
import 'package:project_ta_ke_7/core/models/category_model.dart';

class BarangKeluarServices {

  static var barangKeluarDB = new BarangKeluarDB();
  static var produkDB = new ProductDB();

  Future<bool> create(BarangKeluarRequest barangKeluar, int lastStock) async {
    var _result = await barangKeluarDB.create(barangKeluar);
    await produkDB.updateProdukStok(barangKeluar.produkId, lastStock);

    return _result != null ? true : false;
  }

  Future<List<BarangKeluarModel>> getAll() async {
    var _result = await barangKeluarDB.getAll();

    var data = new List<BarangKeluarModel>();
    _result.forEach((barang) {
      data.add(BarangKeluarModel.fromJson(barang));
    });

    return data;
  }

  Future<int> getTotalQuantity() async {
    var _result = await barangKeluarDB.getTotalQuantity();
    return _result[0]["total"];
  }

  Future<bool> delete(String id, int lastStock, int produkID) async {
    var _result = await barangKeluarDB.delete(id);
    await produkDB.updateProdukStok(produkID, lastStock);

    return _result != null ? true : false;
  }

  Future<bool> deleteByProdukID(String produkID) async {
    var _result = await barangKeluarDB.deleteByProductID(produkID);
    return _result != null ? true : false;
  }

}