import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/barang_keluar_model.dart';
import 'package:project_ta_ke_7/core/models/barang_masuk_model.dart';
import 'package:project_ta_ke_7/core/models/produk_model.dart';
import 'package:project_ta_ke_7/core/utils/dialog_utils.dart';
import 'package:project_ta_ke_7/core/viewmodels/barang_keluar/barang_keluar_provider.dart';
import 'package:project_ta_ke_7/core/viewmodels/barang_masuk/barang_masuk_provider.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';
import 'package:project_ta_ke_7/ui/router/router_generator.dart';
import 'package:project_ta_ke_7/ui/widget/input_widget.dart';
import 'package:project_ta_ke_7/ui/widget/primary_button.dart';
import 'package:provider/provider.dart';

class CreateBarangMasukScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Buat Barang Masuk",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: CreateBarangMasukBody()
      ),
    );
  }
}

class CreateBarangMasukBody extends StatefulWidget {

  @override
  _CreateBarangMasukBodyState createState() => _CreateBarangMasukBodyState();
}

class _CreateBarangMasukBodyState extends State<CreateBarangMasukBody> {
  var quantityController = TextEditingController();
  var produkController = TextEditingController();
  var vendorController = TextEditingController();
  ProdukModel selectedProduk;

  void chooseProduk() async {
    var result = await Navigator.pushNamed(context, RouterGenerator.routeChooseProduk);
    if (result != null) {
      setState(() {
        selectedProduk = result;
      });
      produkController.text = selectedProduk.title;
    }
  }

  void createBarangMasuk() {
    
    //* check field conditions
    if (produkController.text.isNotEmpty && quantityController.text.isNotEmpty
      && vendorController.text.isNotEmpty && selectedProduk != null) {

        var barangMasuk = BarangMasukRequest(
          produkId: selectedProduk.id,
          quantity: int.parse(quantityController.text),
          vendor: vendorController.text
        );

        Provider.of<BarangMasukProvider>(context, listen: false)
          .create(barangMasuk, (selectedProduk.stock + int.parse(quantityController.text)), context);
    } else {
      DialogUtils.instance.showInfo(context, 
        "Semua bagian tidak boleh kosong", 
        Icons.error, "OK");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _fieldProduk(),
          SizedBox(height: 10),
          _fieldQuantity(),
          SizedBox(height: 10),
          _fieldVendor(),
          SizedBox(height: 30),
          _buttonCreate()
        ],
      ),
    );
  }

  Widget _fieldProduk() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Produk",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15)
            ),
            SizedBox(height: 10),
            InputWidget(
              controller: produkController,
              action: TextInputAction.done,
              type: TextInputType.text,
              readOnly: true,
              onClick: () => chooseProduk(),
              hintText: "Press to get product",
            )
          ],
        );
      },
    );
  }

  Widget _fieldQuantity() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Quantity",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15)
            ),
            SizedBox(height: 10),
            InputWidget(
              controller: quantityController,
              action: TextInputAction.done,
              type: TextInputType.number,
              hintText: "Enter your quantity",
            )
          ],
        );
      },
    );
  }

  Widget _fieldVendor() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Vendor",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15)
            ),
            SizedBox(height: 10),
            InputWidget(
              controller: vendorController,
              action: TextInputAction.done,
              type: TextInputType.text,
              hintText: "Enter vendor name",
            )
          ],
        );
      },
    );
  }

  Widget _buttonCreate() {
    return PrimaryButton(
      text: "Submit",
      color: primaryColor,
      onPress: () => createBarangMasuk()
    );
  }
}