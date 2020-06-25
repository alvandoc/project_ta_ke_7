import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/barang_masuk_model.dart';
import 'package:project_ta_ke_7/core/services/barang_masuk/barang_masuk_services.dart';
import 'package:project_ta_ke_7/core/utils/dialog_utils.dart';
import 'package:project_ta_ke_7/core/viewmodels/product/product_provider.dart';
import 'package:project_ta_ke_7/ui/router/router_generator.dart';
import 'package:provider/provider.dart';

class BarangMasukProvider extends ChangeNotifier {

  //*-----------------
  //* Property Field
  //*-----------------

  List<BarangMasukModel> _barangMasukList;
  List<BarangMasukModel> get barangMasukList => _barangMasukList;

  int _totalQuantity;
  int get totalQuantity => _totalQuantity;

  //* Services barang masuk
  var barangMasukService = new BarangMasukService();

  //*-----------------
  //* Function Field
  //*-----------------

  //* Function to get all produk
  void getAll() async {
    var result = await barangMasukService.getAll();

    _barangMasukList = new List<BarangMasukModel>();
    if (result != null && result.length > 0) {
      _barangMasukList = result;
    }
    notifyListeners();
  }


  void getTotalQuantity() async {
    var result = await barangMasukService.getTotalQuantity();
    if (result != null) {
      _totalQuantity = result;
    } else {
      _totalQuantity = 0;
    }
    notifyListeners();
  }


   //* Function to create barang masuk
  void create(BarangMasukRequest barangMasuk, int lastStock, BuildContext context) async {
    //* show loading
    DialogUtils.instance.showLoading(context, "Membuat Barang Masuk");
    
    var result = await barangMasukService.create(barangMasuk, lastStock);
    
    //* Close loading
    Navigator.pop(context);

    //* Reloading product again
    clearBarangMasuk();
    //* Reloading produk
    Provider.of<ProductProvider>(context, listen: false).clearProduct();
    //* Update total stock
    addQuantity(barangMasuk.quantity);
    
    //* If create produk success
    if (result) { 
      DialogUtils.instance.showInfo(context, "Berhasil membuat barang masuk", Icons.check, "OK", onClick: () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else {
      DialogUtils.instance.showInfo(context, "Gagal membuat barang masuk", Icons.error, "OK");
    }

    notifyListeners();
  }


  void delete(String id, int lastQuantity, BuildContext context) {
    DialogUtils.instance.showOptions(context, 
      "Anda yakin ingin menghapus data?", Icons.warning, onClickYes: () async {
      
      //* Close dialog options
      Navigator.pop(context);
      
      //* show loading
      DialogUtils.instance.showLoading(context, "Menghapus Barang Masuk");
      
      var result = await barangMasukService.delete(id, lastQuantity);
      
      //* Close loading
      Navigator.pop(context);

      var barang = _barangMasukList.firstWhere((element) => element.id.toString() == id);
      //* update total stock
      removeQuantity(barang.quantity);

      //* Removing barang masuk from list
      _barangMasukList.removeWhere((element) => element.id.toString() == id);

      //* Reloading produk
      Provider.of<ProductProvider>(context, listen: false).clearProduct();

      
      //* If remove category success
      if (result) { 
        DialogUtils.instance.showInfo(context, "Berhasil menghapus barang masuk", Icons.check, "OK");
      } else {
        DialogUtils.instance.showInfo(context, "Gagal menghapus barang masuk", Icons.error, "OK");
      }

      notifyListeners();
    });
  }

  void goToProduct(String id, BuildContext context) async {
    final productProv = Provider.of<ProductProvider>(context, listen: false);
    var product = await productProv.getById(id);
    Navigator.pushNamed(context, RouterGenerator.routeProdukDetail, arguments: product);
  }

  void clearBarangMasuk() {
    _barangMasukList = null;
    notifyListeners();
  }

  void addQuantity(int quantity) {
    _totalQuantity += quantity;
    notifyListeners();
  }

  void removeQuantity(int quantity) {
    _totalQuantity -= quantity;
    notifyListeners();
  }

}