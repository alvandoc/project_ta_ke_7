import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/auth_model.dart';
import 'package:project_ta_ke_7/core/services/auth/auth_services.dart';
import 'package:project_ta_ke_7/core/utils/auth_utils.dart';
import 'package:project_ta_ke_7/core/utils/dialog_utils.dart';
import 'package:project_ta_ke_7/ui/router/router_generator.dart';

class AuthProvider extends ChangeNotifier {

  //*-----------------
  //* Property Field
  //*-----------------

  //* Sign in user
  UserModel _user;
  UserModel get user => _user;

  //* Services produk
  var authServices = new AuthServices();


  //*-----------------
  //* Function Field
  //*-----------------

  //* Function to create produk
  void create(RegisterModel register, BuildContext context) async {

    //* Check if username not exists
    var result = await authServices.usernameExists(register.username);

    if (!result) {
      //* show loading
      DialogUtils.instance.showLoading(context, "Membuat User");
      
      var result = await authServices.register(register);
      
      //* Close loading
      Navigator.pop(context);

      //* If create produk success
      if (result) { 
        DialogUtils.instance.showInfo(context, "Berhasil membuat user", Icons.check, "OK", onClick: () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      } else {
        DialogUtils.instance.showInfo(context, "Gagal membuat user", Icons.error, "OK");
      }
    } else {
      DialogUtils.instance.showInfo(context, "Username sudah terdaftar", Icons.error, "OK");
    }

    notifyListeners();
  }

  //* Function to handle login
  void login(String username, String password, BuildContext context) async {
    
    //* Check if username exists
    var result = await authServices.usernameExists(username);
    if (result) {
      //* Show loading
      DialogUtils.instance.showLoading(context, "Mencoba login");

      var _res = await authServices.usernameAndPasswordExists(username, password);
      Navigator.pop(context);

      //* If username password correct
      if (_res) {

        //* Get user detail
        _user = await authServices.getUser(username);
        //* Save to local storage
        AuthUtils.instance.saveSession(_user);

        DialogUtils.instance.showInfo(context, "Berhasil login", Icons.check, "OK", onClick: () {
          Navigator.pushNamedAndRemoveUntil(context, RouterGenerator.routeHome, (route) => false);
        });

        notifyListeners();
      } else {
        DialogUtils.instance.showInfo(context, "Username atau password salah", Icons.error, "OK");
      }
    } else {
      DialogUtils.instance.showInfo(context, 
        "Username belum terdaftar", 
        Icons.error, "OK");
    }
  }

  void checkSession(BuildContext context) async {
    var _check = await AuthUtils.instance.checkSession();

    if (_check != null) {
      bool sessionStatus = _check;
      //* If the user already login then navigate to home
      if (sessionStatus) {
        _user = await AuthUtils.instance.getUser();
        Navigator.pushNamedAndRemoveUntil(context, RouterGenerator.routeHome, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, RouterGenerator.routeLogin, (route) => false);
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(context, RouterGenerator.routeLogin, (route) => false);
    }
  }

  void logout(BuildContext context) async {
    await AuthUtils.instance.clearSession();
    Navigator.pushNamedAndRemoveUntil(context, RouterGenerator.routeLogin, (route) => false);
    notifyListeners();
  }
}