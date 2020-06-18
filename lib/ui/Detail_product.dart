import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_ta_ke_7/models/produk_mdl.dart';
import 'package:project_ta_ke_7/services/produk_service.dart';
import 'package:project_ta_ke_7/ui/update_screen.dart';

class DetailProduk extends StatelessWidget {
  ProdModel prodModel;
  DetailProduk({this.prodModel});

  void deleteFood(BuildContext context) async {
    await ProdukServices.delete(prodModel);
    Fluttertoast.showToast(
        msg: "Berhasil Menghapus Product",
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Colors.indigo, Colors.indigoAccent])),
        ),
        title: Text(prodModel.title),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateScreen(
                            prodModel: prodModel,
                          ))),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: () => deleteFood(context),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                )),
          ),
        ],
      ),
      body: DetailBody(prodModel: prodModel),
    );
  }
}

class DetailBody extends StatelessWidget {
  ProdModel prodModel;
  DetailBody({this.prodModel});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Bagian Untuk Meload Gambar
          new Stack(
            children: <Widget>[
              new ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
                child: Image.memory(
                  base64Decode(prodModel.image),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width / 1,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          new Card(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Text('Jumlah : ${prodModel.jumlah.toString()}',
                            style: TextStyle(fontSize: 26)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Harga: Rp ${prodModel.harga}",
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.fade,
                        )
                      ],
                    ),
                  ),
                ],
              )),
          new SizedBox(height: 4),
          new Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      new Icon(Icons.assignment, size: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: new Text(
                          "Deskripsi",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(
                    prodModel.deskripsi,
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
