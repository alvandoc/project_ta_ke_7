import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/barang_keluar_model.dart';
import 'package:project_ta_ke_7/core/viewmodels/barang_keluar/barang_keluar_provider.dart';
import 'package:project_ta_ke_7/core/viewmodels/barang_masuk/barang_masuk_provider.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';
import 'package:project_ta_ke_7/ui/widget/barang_keluar_item.dart';
import 'package:project_ta_ke_7/ui/widget/barang_masuk_item.dart';
import 'package:project_ta_ke_7/ui/widget/conditions/loading.dart';
import 'package:project_ta_ke_7/ui/widget/conditions/no_data.dart';
import 'package:provider/provider.dart';

class LastBarangHistory extends StatefulWidget {
  @override
  _LastBarangHistoryState createState() => _LastBarangHistoryState();
}

class _LastBarangHistoryState extends State<LastBarangHistory> {

  int selectedMenu = 0;
  List<String> menuList = ["Masuk", "Keluar"];
  
  void changeSelected(int index) {
    setState(() {
      selectedMenu = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _headMenu(),
          selectedMenu == 0
            ? _barangMasukList()
            : _barangKeluarList()
        ],
      ),
    );
  }

  Widget _headMenu() {
    return Row(
      children: menuList.asMap().map((key, value) => MapEntry(
        key, _headItem(key, value)
      )).values.toList(),
    );
  }

  Widget _headItem(int index, String title) {
    return InkWell(
      onTap: () => changeSelected(index),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            index == 0 
              ? Icon(Icons.arrow_downward, color: selectedMenu == index ? Colors.green : Colors.grey)
              : Icon(Icons.arrow_upward, color: selectedMenu == index ? Colors.red : Colors.grey),
            SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: 17, 
                color: selectedMenu == index ? primaryColor : Colors.grey, 
                fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  Widget _barangKeluarList() {
    return Builder(
      builder: (context) {
        return Consumer<BarangKeluarProvider>(
          builder: (context, barangProv, _) {

            if (barangProv.barangKeluarList == null) {
              barangProv.getAll();
              return LoadingFull();
            }

            if (barangProv.barangKeluarList.length == 0) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    "Belum ada barang keluar",
                    style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black87),
                  ),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: barangProv.barangKeluarList.length >= 5 ? 5 : barangProv.barangKeluarList.length,
              itemBuilder: (context, index) {
                var barang = barangProv.barangKeluarList[index];
                return BarangKeluarItem(
                  barang: barang,
                  enableDelete: false,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _barangMasukList() {
    return Builder(
      builder: (context) {
        return Consumer<BarangMasukProvider>(
          builder: (context, barangProv, _) {

            if (barangProv.barangMasukList == null) {
              barangProv.getAll();
              return LoadingFull();
            }

            if (barangProv.barangMasukList.length == 0) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    "Belum ada barang masuk",
                    style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black87),
                  ),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: barangProv.barangMasukList.length >= 5 ? 5 : barangProv.barangMasukList.length,
              itemBuilder: (context, index) {
                var barang = barangProv.barangMasukList[index];
                return BarangMasukItem(
                  barang: barang,
                  enableDelete: false,
                );
              },
            );
          },
        );
      },
    );
  }

}
