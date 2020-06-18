import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ta_ke_7/models/produk_mdl.dart';
import 'package:project_ta_ke_7/services/produk_service.dart';
import 'package:project_ta_ke_7/widget/custom_textfield.dart';

class UpdateScreen extends StatelessWidget {
  ProdModel prodModel;
  UpdateScreen({this.prodModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Colors.indigo, Colors.indigoAccent])),
        ),
        title: Text("Edit Barang"),
      ),
      body: EditBarang(
        prodModel: prodModel,
      ),
    );
  }
}

class EditBarang extends StatefulWidget {
  ProdModel prodModel;
  EditBarang({this.prodModel});
  @override
  _EditBarangState createState() => _EditBarangState();
}

class _EditBarangState extends State<EditBarang> {
  File image;
  var titleController = TextEditingController();
  var jumlahController = TextEditingController();
  var deskripsiController = TextEditingController();
  var hargaController = TextEditingController();

  void imagePick() async {
    var _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      setState(() {
        image = _image;
      });
    }
  }

  void loadProd() {
    setState(() {
      titleController.text = widget.prodModel.title;
      hargaController.text = widget.prodModel.harga.toString();
      deskripsiController.text = widget.prodModel.deskripsi;
      jumlahController.text = widget.prodModel.jumlah.toString();
    });
  }

  void editProduk() async {
    if (titleController.text.isNotEmpty &&
        jumlahController.text.isNotEmpty &&
        deskripsiController.text.isNotEmpty &&
        hargaController.text.isNotEmpty) {
      ProdModel prodModel = ProdModel(
          title: titleController.text,
          jumlah: int.parse(jumlahController.text),
          deskripsi: deskripsiController.text,
          harga: double.parse(hargaController.text),
          image: image != null
              ? base64Encode(image.readAsBytesSync())
              : widget.prodModel.image);

      var result = await ProdukServices.update(prodModel, widget.prodModel.id);

      // Jika Sukses Insert
      if (result) {
        Fluttertoast.showToast(
            msg: "Berhasil Mengubah Produk",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0);

        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushNamedAndRemoveUntil(
              context, "/home", (Route<dynamic> routes) => false);
        });
      } else {
        Fluttertoast.showToast(
            msg: "Gagal Mengubah Produk",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Silahkan Isi Semua bagian",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    super.initState();
    this.loadProd();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Center(
            child: Container(
              child: InkWell(
                  onTap: () => imagePick(),
                  child: image == null
                      ? Icon(
                          Icons.add_photo_alternate,
                          color: Colors.orange,
                          size: 100,
                        )
                      : Image.file(image, width: 100, height: 100)),
            ),
          ),
          SizedBox(height: 20),
          CustomTextfield(
            action: TextInputAction.done,
            type: TextInputType.text,
            controller: titleController,
            hintText: "Nama Produk",
          ),
          SizedBox(height: 10),
          CustomTextfield(
            action: TextInputAction.done,
            type: TextInputType.number,
            controller: jumlahController,
            hintText: "Jumlah",
          ),
          SizedBox(height: 10),
          CustomTextfield(
            action: TextInputAction.done,
            type: TextInputType.multiline,
            controller: deskripsiController,
            hintText: "Deksripsi",
          ),
          SizedBox(height: 10),
          CustomTextfield(
            action: TextInputAction.done,
            type: TextInputType.number,
            controller: hargaController,
            hintText: "Harga",
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              onPressed: () => editProduk(),
              color: Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                "Edit Produk",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
