import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ta_ke_7/models/produk_mdl.dart';
import 'package:project_ta_ke_7/services/produk_service.dart';
import 'package:project_ta_ke_7/ui/Tampilan_awal2.dart';
import 'package:project_ta_ke_7/widget/custom_textfield.dart';

class TambahProduk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Colors.indigo, Colors.indigoAccent])),
        ),
        title: Text("Tambah Produk"),
      ),
      body: BodyTambah(),
    );
  }
}

class BodyTambah extends StatefulWidget {
  @override
  _BodyTambahState createState() => _BodyTambahState();
}

class _BodyTambahState extends State<BodyTambah> {
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

  void tambahProduk() async {
    if (titleController.text.isNotEmpty &&
        jumlahController.text.isNotEmpty &&
        deskripsiController.text.isNotEmpty &&
        hargaController.text.isNotEmpty &&
        image != null) {
      ProdModel prodModel = ProdModel(
          title: titleController.text,
          jumlah: int.parse(jumlahController.text),
          deskripsi: deskripsiController.text,
          harga: double.parse(hargaController.text),
          image: base64Encode(image.readAsBytesSync()));

      var result = await ProdukServices.create(prodModel);

      // Jika Sukses Insert
      if (result) {
        Fluttertoast.showToast(
            msg: "Berhasil menambah makanan",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0);
        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        });
      } else {
        Fluttertoast.showToast(
            msg: "Gagal menambah makanan",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Silahkan isi semua bagian",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
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
                    : Image.file(
                        image,
                        width: 100,
                        height: 100,
                      ),
              ),
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
              onPressed: () => tambahProduk(),
              color: Colors.orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                "Tambah Produk",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ]));
  }
}
