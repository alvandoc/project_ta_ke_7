import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/ui/Tampilan_awal.dart';
import 'package:project_ta_ke_7/ui/Tampilan_awal2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Inventory",
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent
      ),
      home: HalamanAwal(),
    );
  }
}