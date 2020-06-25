import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';

class MenuItem extends StatelessWidget {

  String title;
  String iconPath;
  Function onClick;

  MenuItem({
    @required this.title, @required this.iconPath,
    @required this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onClick(),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryColor.withOpacity(0.1)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(iconPath, width: 32, height: 32, color: primaryColor),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}