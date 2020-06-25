import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/produk_model.dart';
import 'package:project_ta_ke_7/core/utils/currency_utils.dart';
import 'package:project_ta_ke_7/core/utils/dialog_utils.dart';
import 'package:project_ta_ke_7/core/viewmodels/product/product_provider.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';
import 'package:project_ta_ke_7/ui/router/router_generator.dart';
import 'package:project_ta_ke_7/ui/widget/conditions/no_data.dart';
import 'package:provider/provider.dart';

class ChooseProdukScreen extends StatelessWidget {

  bool allowPickZeroQuantity;
  ChooseProdukScreen({
    this.allowPickZeroQuantity = true
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Pilih Produk",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ProductProvider(),
          )
        ],
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ProdukBody(
            allowPickZeroQuantity: allowPickZeroQuantity,
          )
        ),
      ),
    );
  }
}

class ProdukBody extends StatefulWidget {
  bool allowPickZeroQuantity;
  ProdukBody({
    this.allowPickZeroQuantity = true
  });
  @override
  _ProdukBodyState createState() => _ProdukBodyState();
}

class _ProdukBodyState extends State<ProdukBody> {
  void pickProduk(ProdukModel produk) {

    if (widget.allowPickZeroQuantity) {
      if (produk.stock > 0) {
        Navigator.pop(context, produk);
      } else {
        DialogUtils.instance.showInfo(context, 
          "Produk kosong", Icons.error, "OK");
      }
    } else {
      Navigator.pop(context, produk);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          _produkList(),
          SizedBox(height: 40)
        ],
      ),
    );
  }

  Widget _produkList() {
    return Builder(
      builder: (context) {
        return Consumer<ProductProvider>(
          builder: (context, produkProv, _) {

            if (produkProv.produkList == null) {
              produkProv.getAll();
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (produkProv.produkList.length == 0) {
              return NoData(
                text: "Belum ada produk",
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: produkProv.produkList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {

                var produk = produkProv.produkList[index];
                return _produkItem(produk);
              },
            );
          },
        );
      },
    );
  }

  Widget _produkItem(ProdukModel produk) {
    return Builder(
      builder: (context) {
        return GestureDetector(
          onTap: () => pickProduk(produk),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: deviceWidth(context),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.05),
                  offset: Offset(0, 3),
                  blurRadius: 12,
                  spreadRadius: 3
                )
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                    ),
                    image: DecorationImage(
                      image: MemoryImage(
                        base64Decode(produk.image)
                      ),
                      fit: BoxFit.cover
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              produk.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87, 
                                fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Rp ${formatter.format(produk.price)}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green, 
                              fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),

                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(IconData(produk.categoryIcon, fontFamily: "MaterialIcons"), color: primaryColor),
                              SizedBox(width: 5),
                              Text(
                                produk.category,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87),
                              ),
                            ],
                          ),

                          SizedBox(width: 5),
                          Text(
                            "•",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black45),
                          ),
                          SizedBox(width: 5),

                          Text(
                            "Stok: ${produk.stock.toString()}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87),
                          ),
                        ],
                      )

                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}