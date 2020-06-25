import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/category_model.dart';
import 'package:project_ta_ke_7/core/services/category/category_services.dart';
import 'package:project_ta_ke_7/core/utils/dialog_utils.dart';
import 'package:project_ta_ke_7/ui/router/router_generator.dart';

class CategoryProvider extends ChangeNotifier {

  //*-----------------
  //* Property Field
  //*-----------------

  List<CategoryModel> _categoryList;
  List<CategoryModel> get categoryList => _categoryList;

  //* Services category
  var categoryServices = new CategoryServices();

  //*-----------------
  //* Function Field
  //*-----------------

  //* Function to create category
  void create(CategoryModel category, BuildContext context) async {
    //* show loading
    DialogUtils.instance.showLoading(context, "Membuat Kategori");
    
    var result = await categoryServices.create(category);
    
    //* Close loading
    Navigator.pop(context);

    //* Adding to category list without fetch all category again
    _categoryList.add(category);
    
    //* If create category success
    if (result) { 
      DialogUtils.instance.showInfo(context, "Berhasil membuat kategori", Icons.check, "OK", onClick: () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } else {
      DialogUtils.instance.showInfo(context, "Gagal membuat kategori", Icons.error, "OK");
    }

    notifyListeners();
  }

  //* Function to delete category
  void delete(String id, BuildContext context) {

    DialogUtils.instance.showOptions(context, 
      "Anda yakin ingin menghapus data?", Icons.warning, onClickYes: () async {
      
      //* Close dialog options
      Navigator.pop(context);
      
      //* show loading
      DialogUtils.instance.showLoading(context, "Menghapus Kategori");
      
      var result = await categoryServices.delete(id);
      
      //* Close loading
      Navigator.pop(context);

      //* Removing category from list
      _categoryList.removeWhere((element) => element.id.toString() == id);
      
      //* If remove category success
      if (result) { 
        DialogUtils.instance.showInfo(context, "Berhasil menghapus kategori", Icons.check, "OK");
      } else {
        DialogUtils.instance.showInfo(context, "Gagal menghapus kategori", Icons.error, "OK");
      }

      notifyListeners();
    });

  }

  //* Function to get all category
  void getAll() async {
    var result = await categoryServices.getAll();

    _categoryList = new List<CategoryModel>();
    if (result != null && result.length > 0) {
      _categoryList = result;
    }
    notifyListeners();
  }
}