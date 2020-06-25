import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';

class NoData extends StatelessWidget {

  String text;
  NoData({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeight(context),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 20)
        ),
      ),
    );
  }
}