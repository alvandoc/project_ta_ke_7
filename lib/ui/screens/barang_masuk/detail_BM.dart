import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ta_ke_7/core/models/produk_model.dart';
import 'package:project_ta_ke_7/core/utils/currency_utils.dart';
import 'package:project_ta_ke_7/core/viewmodels/product/product_provider.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailBM extends StatefulWidget {
  ProdukModel produk;
  DetailBM({@required this.produk});

  @override
  _DetailBM createState() => _DetailBM();
}

class _DetailBM extends State<DetailBM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Detail Produk",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ProdukDetailBody(
          produk: widget.produk,
        ),
      ),
      bottomSheet: _bottomWidget(),
    );
  }

  Widget _bottomWidget() {
    return Container(
        height: 60,
        child: Consumer<ProductProvider>(
          builder: (context, produkProv, _) {
            return Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.indigoAccent,
                    child: Material(
                      type: MaterialType.transparency,
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () =>
                            produkProv.editProduk(context, widget.produk),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.edit, color: Colors.white),
                              SizedBox(width: 5),
                              Text("Edit Produk",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}

// ignore: must_be_immutable
class ProdukDetailBody extends StatefulWidget {
  ProdukModel produk;
  ProdukDetailBody({@required this.produk});

  @override
  _ProdukDetailBodyState createState() => _ProdukDetailBodyState();
}

class _ProdukDetailBodyState extends State<ProdukDetailBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _headerImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _titlePriceProduct(),
                SizedBox(height: 25),
                _stockCategory(),
                SizedBox(height: 20),
                _description()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _headerImage() {
    return Builder(
      builder: (context) {
        return Container(
          width: deviceWidth(context),
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            image: DecorationImage(
                image: MemoryImage(base64Decode(widget.produk.image)),
                fit: BoxFit.cover),
          ),
        );
      },
    );
  }

  Widget _titlePriceProduct() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Text(
            "Nama Produk : ${(widget.produk.title)})",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(width: 10),
        Text(
          "Rp ${formatter.format(widget.produk.price)}",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 16, color: Colors.green, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _stockCategory() {
    return Container(
      decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(7)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  child: SvgPicture.asset("$iconAsset/storage.svg",
                      color: primaryColor),
                ),
                SizedBox(height: 5),
                Text(
                  "${widget.produk.stock.toString()} Tersedia",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
            SizedBox(width: 40),
            Container(
              width: 1,
              height: 40,
              color: Colors.black12.withOpacity(0.2),
            ),
            SizedBox(width: 40),
            Column(
              children: <Widget>[
                Container(
                  child: Icon(
                      IconData(widget.produk.categoryIcon,
                          fontFamily: "MaterialIcons"),
                      color: primaryColor,
                      size: 32),
                ),
                SizedBox(height: 5),
                Text(
                  widget.produk.category,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _description() {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(8),
        child:Text(
          "Deskripsi : ",
          style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        ),
        Padding(padding: EdgeInsets.all(8),
        child: Text("${(widget.produk.description)}", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),),
        
        )
      ],
    );
  }
}
