import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';

class LoadingFull extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}