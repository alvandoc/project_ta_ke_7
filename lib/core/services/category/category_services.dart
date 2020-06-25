
import 'package:project_ta_ke_7/core/database/category/category_db.dart';
import 'package:project_ta_ke_7/core/models/category_model.dart';

class CategoryServices {

  static var categoryDB = new CategoryDB();

  Future<bool> create(CategoryModel category) async {
    var _result = await categoryDB.create(category);
    return _result != null ? true : false;
  }

  Future<bool> delete(String id) async {
    var _result = await categoryDB.delete(id);
    return _result != null ? true : false;
  }

  Future<List<CategoryModel>> getAll() async {
    var _result = await categoryDB.getAll();

    var data = new List<CategoryModel>();
    _result.forEach((category) {
      data.add(CategoryModel.fromJson(category));
    });

    return data;
  }

}