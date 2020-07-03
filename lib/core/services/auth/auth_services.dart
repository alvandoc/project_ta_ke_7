

import 'package:project_ta_ke_7/core/database/auth/auth_db.dart';
import 'package:project_ta_ke_7/core/models/auth_model.dart';

class AuthServices {
  static var authDB = AuthDB();

  Future<bool> register(RegisterModel register) async {
    var _result = await authDB.register(register);
    return _result != null ? true : false;
  }

  Future<bool> usernameExists(String username) async {
    var _result = await authDB.usernameExists(username);
    return _result != null && _result.length > 0 ? true : false;
  }

  Future<UserModel> getUser(String username) async {
    var _result = await authDB.getUser(username);

    var user = UserModel.fromJson(_result);
    return user;
  }

  Future<bool> usernameAndPasswordExists(String username, String password) async {
    var _result = await authDB.usernameAndPasswordExists(username, password);
    return _result != null && _result.length > 0 ? true : false;
  }
}