import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/category_model.dart';
import 'package:project_ta_ke_7/core/models/produk_model.dart';
import 'package:project_ta_ke_7/core/services/barang_keluar/barang_keluar_services.dart';
import 'package:project_ta_ke_7/core/services/barang_masuk/barang_masuk_services.dart';
import 'package:project_ta_ke_7/core/services/category/category_services.dart';
import 'package:project_ta_ke_7/core/services/product/product_services.dart';
import 'package:project_ta_ke_7/core/utils/dialog_utils.dart';
import 'package:project_ta_ke_7/core/viewmodels/barang_keluar/barang_keluar_provider.dart';
import 'package:project_ta_ke_7/core/viewmodels/barang_masuk/barang_masuk_provider.dart';
import 'package:project_ta_ke_7/ui/router/router_generator.dart';
import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier {

  //*-----------------
  //* Property Field
  //*-----------------

  List<ProdukModel> _produkList;
  List<ProdukModel> get produkList => _produkList;

  //* Services produk
  var produkService = new ProductServices();
  var barangMasukService = new BarangMasukService();
  var barangKeluarService = new BarangKeluarServices();

  //*-----------------
  //* Function Field
  //*-----------------

  //* Function to get all produk
  void getAll() async {
    var result = await produkService.getAll();

    _produkList = new List<ProdukModel>();
    if (result != null && result.length > 0) {
      _produkList = result;
    }
    notifyListeners();
  }

  //* Get product by id
  Future<ProdukModel> getById(String id) async {
    var result = await produkService.getProductById(id);
    return result;
  }

  //* Function to create produk
  void create(ProdukModel produk, BuildContext context) async {
    //* show loading
    DialogUtils.instance.showLoading(context, "Membuat Produk");
    
    var result = await produkService.create(produk);
    
    //* Close loading
    Navigator.pop(context);

    //* Reloading product again
    clearProduct();
    
    //* If create produk success
    if (result) { 
      DialogUtils.instance.showInfo(context, "Berhasil membuat produk", Icons.check, "OK", onClick: () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else {
      DialogUtils.instance.showInfo(context, "Gagal membuat produk", Icons.error, "OK");
    }

    notifyListeners();
  }


  //* Function to update produk
  void update(ProdukModel produk, int id, BuildContext context) async {
    //* show loading
    DialogUtils.instance.showLoading(context, "Mengubah Produk");

    var result = await produkService.update(produk, id);
    
    //* Close loading
    Navigator.pop(context);

    //* Reloading product again
    clearProduct();
    Provider.of<BarangKeluarProvider>(context, listen: false).clearBarangKeluar();
    
    //* If create produk success
    if (result) { 
      DialogUtils.instance.showInfo(context, "Berhasil mengubah produk", Icons.check, "OK", onClick: () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else {
      DialogUtils.instance.showInfo(context, "Gagal mengubah produk", Icons.error, "OK");
    }

    notifyListeners();
  }

  void deleteProduk(BuildContext context, String id) {
    DialogUtils.instance.showOptions(context, "Anda yakin ingin menghapus data?", Icons.warning, onClickYes: () async {
      //* Close dialog options
      Navigator.pop(context);
      
      //* show loading
      DialogUtils.instance.showLoading(context, "Menghapus Produk");
      
      //* Remove barang masuk and barang keluar by produk ID
      await barangMasukService.deleteByProdukID(id);
      await barangKeluarService.deleteByProdukID(id);
      //* Remove produk
      var result = await produkService.delete(id);
      
      //* Close loading
      Navigator.pop(context);

      //* Reloading product
      await clearProduct();

      //* Reload barang masuk and barang keluar list
      final barangMasukProv = await Provider.of<BarangMasukProvider>(context, listen: false);
      final barangKeluarProv = await Provider.of<BarangKeluarProvider>(context, listen: false);
      await barangMasukProv.clearBarangMasuk();
      await barangKeluarProv.clearBarangKeluar();

      //* Reload barang masuk & barang keluar quantity
      await barangMasukProv.clearQuantity();
      await barangKeluarProv.clearQuantity();
      
      //* If remove category success
      if (result) { 
        DialogUtils.instance.showInfo(context, "Berhasil menghapus produk", Icons.check, "OK", onClick: () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      } else {
        DialogUtils.instance.showInfo(context, "Gagal menghapus produk", Icons.error, "OK");
      }

      notifyListeners();
    });
  }

  void editProduk(BuildContext context, ProdukModel produk) {
    Navigator.pushNamed(context, RouterGenerator.routeEditProduk, arguments: produk);
  }

  void clearProduct() {
    _produkList = null;
    notifyListeners();
  }
}