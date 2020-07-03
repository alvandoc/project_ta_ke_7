import 'package:flutter/material.dart';

class InputWidget extends StatefulWidget {
  String hintText;
  TextInputAction action;
  TextInputType type;
  bool secureText;
  TextEditingController controller;
  bool readOnly;
  Function onClick;
  int maxLine;
  
  InputWidget({
    @required this.hintText,
    @required this.action,
    @required this.type,
    this.secureText = false,
    @required this.controller,
    this.readOnly = false,
    this.onClick,
    this.maxLine
  });

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: TextField(
          readOnly: widget.readOnly,
          onTap: () => widget.onClick != null ? widget.onClick() : {},
          controller: widget.controller,
          textInputAction: widget.action,
          keyboardType: widget.type,
          obscureText: widget.secureText,
          maxLines: widget.maxLine,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: InputBorder.none
          ),
        ),
      ),
    );
  }
}