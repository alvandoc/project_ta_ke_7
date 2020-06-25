import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  TextInputAction action;
  TextInputType type;
  TextEditingController controller;
  String hintText;

  CustomTextfield({this.action, this.type, this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        textInputAction: action,
        keyboardType: type,
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}
