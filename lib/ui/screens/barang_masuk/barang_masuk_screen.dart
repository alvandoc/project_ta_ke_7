import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/barang_masuk_model.dart';
import 'package:project_ta_ke_7/core/models/produk_model.dart';
import 'package:project_ta_ke_7/core/utils/currency_utils.dart';
import 'package:project_ta_ke_7/core/viewmodels/barang_masuk/barang_masuk_provider.dart';
import 'package:project_ta_ke_7/core/viewmodels/product/product_provider.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';
import 'package:project_ta_ke_7/ui/router/router_generator.dart';
import 'package:project_ta_ke_7/ui/widget/barang_masuk_item.dart';
import 'package:project_ta_ke_7/ui/widget/conditions/loading.dart';
import 'package:project_ta_ke_7/ui/widget/conditions/no_data.dart';
import 'package:provider/provider.dart';

class BarangMasukScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Barang Masuk",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, RouterGenerator.routeCreateBarangMasuk),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: BarangMasukBody()
      ),
    );
  }
}

class BarangMasukBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          _barangMasukList(),
          SizedBox(height: 40)
        ],
      ),
    );
  }

  Widget _barangMasukList() {
    return Builder(
      builder: (context) {
        return Consumer<BarangMasukProvider>(
          builder: (context, barangMasukProv, _) {

            if (barangMasukProv.barangMasukList == null) {
              barangMasukProv.getAll();
              return LoadingFull();
            }

            if (barangMasukProv.barangMasukList.length == 0) {
              return NoData(
                text: "Belum ada barang masuk",
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: barangMasukProv.barangMasukList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {

                var barangMasuk = barangMasukProv.barangMasukList[index];
                return BarangMasukItem(
                  barang: barangMasuk,
                );
              },
            );
          },
        );
      },
    );
  }

}