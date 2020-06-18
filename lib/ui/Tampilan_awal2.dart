import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/models/produk_mdl.dart';
import 'package:project_ta_ke_7/services/produk_service.dart';
import 'package:project_ta_ke_7/ui/Detail_product.dart';
import 'package:project_ta_ke_7/ui/Tambah_produk.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Colors.indigo, Colors.indigoAccent])),
        ),
        title: Text("MyInvetori"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TambahProduk())),
                child: Icon(Icons.add_circle)),
          )
        ],
      ),
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Bagian ini Untuk Produk yang baru ditambahkan
              Text(
                "Daftar Produk",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // di Bagian ini akan kita isi dengan (widget) produk" yang baru ditambahkan
              ListProduct(),
            ],
          ),
        )
      ],
    );
  }
}

class ListProduct extends StatefulWidget {
  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  // Instance Data product
  List<ProdModel> produk;

  // Function untuk load data produk
  void loadData() async {
    var _produk = await ProdukServices.getAll();
    setState(() {
      produk = _produk;
    });
  }

  @override
  void initState() {
    super.initState();
    this.loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (produk == null) {
      return Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.indigoAccent,
      ));
    }

    return Container(
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: produk.length,
            itemBuilder: (context, index) {
              // Menambahkan Item produk dalam list
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Card(
                  elevation: 1,
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailProduk(
                                  prodModel: produk[index],
                                ))),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Bagian Ini untuk Menambahkan title, iamge, dan deskripsi
                          Container(
                              // Bagian Image
                              width: 64,
                              height: 64,
                              child: Image.memory(
                                base64Decode(produk[index].image),
                                fit: BoxFit.cover,
                              )),

                          // Memberi Jarak dengan Sizebox
                          SizedBox(
                            width: 10,
                          ),

                          // Bagian untuk Title dan Deskripsi
                          Column(
                            // Bagian Title
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // TITTLE
                              Text(
                                produk[index].title,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),

                              // Memberi Jarak dengan Sizebox
                              SizedBox(
                                height: 5,
                              ),

                              // Jumlah
                              Container(
                                // Bagian Jumlah
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  "Jumlah : ${produk[index].jumlah.toString()}",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              // Harga
                              Container(
                                // Bagian harga
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      "Rp ${produk[index].harga.toString()}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
