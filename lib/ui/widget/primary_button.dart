import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  String text;
  double fontSize;
  Function onPress;
  Color color;

  PrimaryButton({
    @required this.text, 
    @required this.onPress,
    this.fontSize,
    @required this.color
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => onPress != null ? onPress() : {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: fontSize != null ? fontSize : 18, color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ),
    );
  }
}