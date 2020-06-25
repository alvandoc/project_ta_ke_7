import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/barang_keluar_model.dart';
import 'package:project_ta_ke_7/core/viewmodels/barang_keluar/barang_keluar_provider.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';
import 'package:provider/provider.dart';

class BarangKeluarItem extends StatelessWidget {

  BarangKeluarModel barang;
  bool enableDelete;
  BarangKeluarItem({
    @required this.barang,
    this.enableDelete = true
  });

  @override
  Widget build(BuildContext context) {

    final barangKeluarProv = Provider.of<BarangKeluarProvider>(context, listen: false);
    return Container(
      width: deviceWidth(context),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.07),
            offset: Offset(0, 5),
            blurRadius: 6,
            spreadRadius: 1
          )
        ]
      ),
      child: Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        child: InkWell(
          onTap: () => barangKeluarProv.goToProduct(barang.produkId.toString(), context),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle
                      ),
                      child: Icon(Icons.arrow_upward, color: primaryColor),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          barang.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(IconData(barang.categoryIcon, fontFamily: "MaterialIcons"), color: primaryColor),
                                SizedBox(width: 5),
                                Text(
                                  barang.category,
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
                              "Quantity: ${barang.quantity.toString()}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),

                enableDelete 
                  ?_deleteBarang(barang)
                  : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _deleteBarang(BarangKeluarModel barang) {
    return Builder(
      builder: (context) {
        return Consumer<BarangKeluarProvider>(
          builder: (context, barangProv, _) {
            return Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),
              child: Material(
                type: MaterialType.transparency,
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => barangProv.delete(barang.id.toString(), (barang.stock + barang.quantity) , context),
                  borderRadius: BorderRadius.circular(30),
                  child: Icon(Icons.delete, color: Colors.red)
                )
              ),
            );
          },
        );
      },
    );
  }
}