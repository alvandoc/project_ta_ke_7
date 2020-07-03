import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/barang_keluar_model.dart';
import 'package:project_ta_ke_7/core/services/barang_keluar/barang_keluar_services.dart';
import 'package:project_ta_ke_7/core/utils/dialog_utils.dart';
import 'package:project_ta_ke_7/core/viewmodels/product/product_provider.dart';
import 'package:project_ta_ke_7/ui/router/router_generator.dart';
import 'package:provider/provider.dart';

class BarangKeluarProvider extends ChangeNotifier {

  //*-----------------
  //* Property Field
  //*-----------------

  List<BarangKeluarModel> _barangKeluarList;
  List<BarangKeluarModel> get barangKeluarList => _barangKeluarList;

  int _totalQuantity = 0;
  int get totalQuantity => _totalQuantity;

  //* Services barang keluar
  var barangKeluarServices = BarangKeluarServices();

  //*-----------------
  //* Function Field
  //*-----------------

  void getAll() async {
    var result = await barangKeluarServices.getAll();

    _barangKeluarList = new List<BarangKeluarModel>();
    if (result != null && result.length > 0) {
      _barangKeluarList = result;
    }
    notifyListeners();
  }

  void getTotalQuantity() async {
    var result = await barangKeluarServices.getTotalQuantity();
    if (result != null) {
      _totalQuantity = result;
    } else {
      _totalQuantity = 0;
    }
    notifyListeners();
  }

  //* Function to create barang keluar
  void create(BarangKeluarRequest barangKeluar, int lastStock, BuildContext context) async {
    //* show loading
    DialogUtils.instance.showLoading(context, "Membuat Barang Keluar");
    
    var result = await barangKeluarServices.create(barangKeluar, lastStock);

    //* Close loading
    Navigator.pop(context);

    //* Reloading barang keluar
    clearBarangKeluar();
    //* Reloading produk
    Provider.of<ProductProvider>(context, listen: false).clearProduct();
    //* update total stock
    addQuantity(barangKeluar.quantity);
    
    //* If create barang keluar success
    if (result) { 
      DialogUtils.instance.showInfo(context, "Berhasil membuat barang keluar", Icons.check, "OK", onClick: () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else {
      DialogUtils.instance.showInfo(context, "Gagal membuat barang keluar", Icons.error, "OK");
    }

    notifyListeners();
  }

  void delete(String id, int lastQuantity, BuildContext context) {
    DialogUtils.instance.showOptions(context, 
      "Anda yakin ingin menghapus data?", Icons.warning, onClickYes: () async {
      
      //* Close dialog options
      Navigator.pop(context);
      
      //* show loading
      DialogUtils.instance.showLoading(context, "Menghapus Barang Keluar");
      
      var result = await barangKeluarServices.delete(id, lastQuantity);
      
      //* Close loading
      Navigator.pop(context);

      var barang = _barangKeluarList.firstWhere((element) => element.id.toString() == id);
      //* update total stock
      removeQuantity(barang.quantity);

      //* Removing barang masuk from list
      _barangKeluarList.removeWhere((element) => element.id.toString() == id);

      //* Reloading produk
      Provider.of<ProductProvider>(context, listen: false).clearProduct();
      
      
      //* If remove barang masuk success
      if (result) { 
        DialogUtils.instance.showInfo(context, "Berhasil menghapus barang keluar", Icons.check, "OK");
      } else {
        DialogUtils.instance.showInfo(context, "Gagal menghapus barang keluar", Icons.error, "OK");
      }

      notifyListeners();
    });
  }

  void goToProduct(String id, BuildContext context) async {
    final productProv = Provider.of<ProductProvider>(context, listen: false);
    var product = await productProv.getById(id);
    Navigator.pushNamed(context, RouterGenerator.routeProdukDetail, arguments: product);
  }

  void clearBarangKeluar() {
    _barangKeluarList = null;
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