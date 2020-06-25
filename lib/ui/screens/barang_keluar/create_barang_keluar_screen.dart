import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/barang_keluar_model.dart';
import 'package:project_ta_ke_7/core/models/produk_model.dart';
import 'package:project_ta_ke_7/core/utils/dialog_utils.dart';
import 'package:project_ta_ke_7/core/viewmodels/barang_keluar/barang_keluar_provider.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';
import 'package:project_ta_ke_7/ui/router/router_generator.dart';
import 'package:project_ta_ke_7/ui/widget/input_widget.dart';
import 'package:project_ta_ke_7/ui/widget/primary_button.dart';
import 'package:provider/provider.dart';

class CreateBarangKeluarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Buat Barang Keluar",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: CreateBarangKeluarBody()
      ),
    );
  }
}

class CreateBarangKeluarBody extends StatefulWidget {

  @override
  _CreateBarangKeluarBodyState createState() => _CreateBarangKeluarBodyState();
}

class _CreateBarangKeluarBodyState extends State<CreateBarangKeluarBody> {
  var quantityController = TextEditingController();
  var produkController = TextEditingController();
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

  void createBarangKeluar() {
    
    //* check field conditions
    if (produkController.text.isNotEmpty && quantityController.text.isNotEmpty
      && selectedProduk != null) {

        if (selectedProduk.stock >= int.parse(quantityController.text)){
          var barangKeluar = BarangKeluarRequest(
            produkId: selectedProduk.id,
            quantity: int.parse(quantityController.text)
          );

          Provider.of<BarangKeluarProvider>(context, listen: false)
            .create(barangKeluar, (selectedProduk.stock - int.parse(quantityController.text)), context);
        } else {
          DialogUtils.instance.showInfo(context, 
          "Stok tidak mencukupi", 
          Icons.error, "OK");
        }
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

  Widget _buttonCreate() {
    return PrimaryButton(
      text: "Submit",
      color: primaryColor,
      onPress: () => createBarangKeluar()
    );
  }
}