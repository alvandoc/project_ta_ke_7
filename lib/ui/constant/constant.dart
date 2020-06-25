import 'package:flutter/material.dart';

//* Constant Color
Color primaryColor = Colors.indigo;

//* Assets Location
String iconAsset = "assets/icons";
// String imageAsset = "assets/images";

//* device size
double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

//* Constant Base Text Styling
TextStyle styleHeader = TextStyle(
  fontSize: 17,
  color: Colors.black,
  fontWeight: FontWeight.w700
);