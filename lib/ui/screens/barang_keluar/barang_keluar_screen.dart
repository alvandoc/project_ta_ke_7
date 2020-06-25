import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/barang_keluar_model.dart';
import 'package:project_ta_ke_7/core/models/produk_model.dart';
import 'package:project_ta_ke_7/core/viewmodels/barang_keluar/barang_keluar_provider.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';
import 'package:project_ta_ke_7/ui/router/router_generator.dart';
import 'package:project_ta_ke_7/ui/widget/barang_keluar_item.dart';
import 'package:project_ta_ke_7/ui/widget/conditions/loading.dart';
import 'package:project_ta_ke_7/ui/widget/conditions/no_data.dart';
import 'package:provider/provider.dart';

class BarangKeluarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Barang Keluar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, RouterGenerator.routeCreateBarangKeluar),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: BarangKeluarBody()
      ),
    );
  }
}

class BarangKeluarBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          _barangList(),
          SizedBox(height: 40)
        ],
      ),
    );
  }

  Widget _barangList() {
    return Builder(
      builder: (context) {
        return Consumer<BarangKeluarProvider>(
          builder: (context, barangProv, _) {

            if (barangProv.barangKeluarList == null) {
              barangProv.getAll();
              return LoadingFull();
            }

            if (barangProv.barangKeluarList.length == 0) {
              return NoData(
                text: "Belum ada barang keluar",
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: barangProv.barangKeluarList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {

                var barang = barangProv.barangKeluarList[index];
                return BarangKeluarItem(
                  barang: barang,
                );
              },
            );
          },
        );
      },
    );
  }

  
}