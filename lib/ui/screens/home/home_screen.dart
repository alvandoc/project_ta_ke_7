import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ta_ke_7/core/viewmodels/barang_keluar/barang_keluar_provider.dart';
import 'package:project_ta_ke_7/core/viewmodels/barang_masuk/barang_masuk_provider.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';
import 'package:project_ta_ke_7/ui/router/router_generator.dart';
import 'package:project_ta_ke_7/ui/screens/home/last_barang_history.dart';
import 'package:project_ta_ke_7/ui/widget/header_item.dart';
import 'package:project_ta_ke_7/ui/widget/menu_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: primaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "My Inventory",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: HomeBody()
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));
    return Container(
      child: Stack(
        children: <Widget>[
          _backgroundHeader(),
          _contentBody()
        ],
      )
    );
  }

  Widget _backgroundHeader() {
    return Builder(
      builder: (context) {
        return Container(
          width: deviceWidth(context),
          height: 150,
          color: primaryColor,
        );
      },
    );
  }

  Widget _contentBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 70),
        _titleHeader(),
        SizedBox(height: 5),
        _headerStock(),
        SizedBox(height: 30),
        _menuItem(),
        SizedBox(height: 30),
        LastBarangHistory()
      ],
    );
  }


  Widget _titleHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Perhitungan Stok Barang",
        style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _headerStock() {
    return Builder(
      builder: (context) {
        return Container(
          width: deviceWidth(context),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                offset: Offset(0, 12),
                blurRadius: 10,
                spreadRadius: 3
              )
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Consumer2<BarangKeluarProvider, BarangMasukProvider>(
                  builder: (context, barangKeluarProv, barangMasukProv, _) {

                    if (barangKeluarProv.totalQuantity == null && barangMasukProv.totalQuantity == null) {
                      return CircularProgressIndicator();
                    }

                    return HeaderItem(
                      iconPath: "${iconAsset}/storage.svg",
                      title: "Total",
                      value: (barangMasukProv.totalQuantity + barangKeluarProv.totalQuantity).toString(),
                    );
                  },
                ),

                Consumer<BarangMasukProvider>(
                  builder: (context, barangProv, _) {

                    if (barangProv.totalQuantity == null) {
                      barangProv.getTotalQuantity();
                      return CircularProgressIndicator();
                    }

                    return HeaderItem(
                      iconPath: "${iconAsset}/stock.svg",
                      title: "Masuk",
                      value: barangProv.totalQuantity.toString(),
                      useIconInfo: true,
                      icon: Icons.arrow_downward,
                      iconColor: Colors.green
                    );
                  },
                ),
                
                Consumer<BarangKeluarProvider>(
                  builder: (context, barangProv, _) {

                    if (barangProv.totalQuantity == null) {
                      barangProv.getTotalQuantity();
                      return CircularProgressIndicator();
                    }

                    return HeaderItem(
                      iconPath: "${iconAsset}/stock.svg",
                      title: "Keluar",
                      value: barangProv.totalQuantity.toString(),
                      useIconInfo: true,
                      icon: Icons.arrow_upward,
                      iconColor: Colors.red
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _menuItem() {
    return Builder(
      builder: (context) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MenuItem(
                    iconPath: "${iconAsset}/product.svg",
                    title: "Produk",
                    onClick: () => Navigator.pushNamed(context, RouterGenerator.routeProduk),
                  ),
                  MenuItem(
                    iconPath: "${iconAsset}/stock.svg",
                    title: "Barang\nMasuk",
                    onClick: () => Navigator.pushNamed(context, RouterGenerator.routeBarangMasuk)
                  ),
                  MenuItem(
                    iconPath: "${iconAsset}/stock.svg",
                    title: "Barang\nKeluar",
                    onClick: () => Navigator.pushNamed(context, RouterGenerator.routeBarangKeluar),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MenuItem(
                    iconPath: "${iconAsset}/category.svg",
                    title: "Kategori",
                    onClick: () => Navigator.pushNamed(context, RouterGenerator.routeCategory),
                  ),
                  MenuItem(
                    iconPath: "${iconAsset}/comingsoon.svg",
                    title: "Coming\nSoon",
                    onClick: () {},
                  ),
                  MenuItem(
                    iconPath: "${iconAsset}/see_more.svg",
                    title: "See\nMore",
                    onClick: () {},
                  ),
                ],
              )
            ],
          )
        );
      },
    );
  }

}
