import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/produk_model.dart';
import 'package:project_ta_ke_7/ui/screens/barang_keluar/barang_keluar_screen.dart';
import 'package:project_ta_ke_7/ui/screens/barang_keluar/choose_produk_screen.dart';
import 'package:project_ta_ke_7/ui/screens/barang_keluar/create_barang_keluar_screen.dart';
import 'package:project_ta_ke_7/ui/screens/barang_masuk/barang_masuk_screen.dart';
import 'package:project_ta_ke_7/ui/screens/barang_masuk/create_barang_masuk_screen.dart';
import 'package:project_ta_ke_7/ui/screens/category/category_screen.dart';
import 'package:project_ta_ke_7/ui/screens/category/create_category_screen.dart';
import 'package:project_ta_ke_7/ui/screens/home/home_screen.dart';
import 'package:project_ta_ke_7/ui/screens/produk/choose_category.dart';
import 'package:project_ta_ke_7/ui/screens/produk/create_produk_screen.dart';
import 'package:project_ta_ke_7/ui/screens/produk/edit_produk_screen.dart';
import 'package:project_ta_ke_7/ui/screens/produk/produk_detail.dart';
import 'package:project_ta_ke_7/ui/screens/produk/produk_screen.dart';


class RouterGenerator {
  //*------------------
  //* Routing name list
  //*------------------

  static const routeHome = "/home";

  static const routeProduk = "/produk";
  static const routeCreateProduk = "/produk/create";
  static const routeProdukDetail = "/produk/detail";
  static const routeEditProduk = "/produk/edit";
  static const routeChooseProduk = "/produk/choose";

  static const routeCategory = "/category";
  static const routeCreateCategory = "/category/create";
  static const routeChooseCategory = "/category/choose";

  static const routeBarangKeluar = "/barang_keluar";
  static const routeCreateBarangKeluar = "/barang_keluar/create";

  static const routeBarangMasuk = "/barang_masuk";
  static const routeCreateBarangMasuk = "/barang_masuk/create";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      case routeProduk:
        return MaterialPageRoute(builder: (_) => ProdukScreen());
        break;
      case routeProdukDetail:
        if (args is ProdukModel) {
          return MaterialPageRoute(builder: (_) => ProdukDetailScreen(
            produk: args,
          ));
        } 

        return _errorRoute();
        break;
      case routeCreateProduk:
        return MaterialPageRoute(builder: (_) => CreateProdukScreen());
        break;
      case routeEditProduk:
        if (args is ProdukModel) {
          return MaterialPageRoute(builder: (_) => EditProdukScreen(
            produk: args,
          ));
        } 

        return _errorRoute();
        break;
      case routeChooseProduk:
        return MaterialPageRoute(builder: (_) => ChooseProdukScreen());
        break;
      
      case routeCategory:
        return MaterialPageRoute(builder: (_) => CategoryScreen());
        break;
      case routeCreateCategory:
        return MaterialPageRoute(builder: (_) => CreateCategoryScreen());
        break;
      case routeChooseCategory:
        return MaterialPageRoute(builder: (_) => ChooseCategoryScreen());
        break;

      case routeBarangKeluar:
        return MaterialPageRoute(builder: (_) => BarangKeluarScreen());
        break;
      case routeCreateBarangKeluar:
        return MaterialPageRoute(builder: (_) => CreateBarangKeluarScreen());
        break;

      case routeBarangMasuk:
        return MaterialPageRoute(builder: (_) => BarangMasukScreen());
        break;
      case routeCreateBarangMasuk:
        return MaterialPageRoute(builder: (_) => CreateBarangMasukScreen());
        break;
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Rute Tidak Ditemukan'),
        ),
        body: Center(
          child: Text(
            'Sepertinya Anda salah jalan',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      );
    });
  }
}