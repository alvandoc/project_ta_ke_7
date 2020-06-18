import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project_ta_ke_7/models/produk_mdl.dart';
import 'package:project_ta_ke_7/ui/Tampilan_awal2.dart';

class HalamanAwal extends StatefulWidget {
  @override
  _HalamanAwalState createState() => _HalamanAwalState();
}

class _HalamanAwalState extends State<HalamanAwal> {  
  DateTime _currentdate = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    String _formatdate = new DateFormat.MMMMEEEEd().format(_currentdate);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Colors.indigo, Colors.indigoAccent])),
              ),
              title: Text(
                "My Inventory",
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
                IconButton(icon: Icon(Icons.settings), onPressed: () {})
              ],
            ),
            drawer: Drawerr(),
            bottomNavigationBar: Curved(),
            body: ListView(children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "$_formatdate",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CardGet(),
              CardPush(),
            ])));
  }
}

class Appbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class CardGet extends StatefulWidget {
  @override
  _CardGetState createState() => _CardGetState();
}

class _CardGetState extends State<CardGet> {
  List<ProdModel> produk;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width / 2,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 10,
        color: Colors.indigoAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text(
                "Stock",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: Text("Total ", style: TextStyle(color: Colors.white)),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: Text("Barang Masuk",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: Text("barang Keluar",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardPush extends StatefulWidget {
  @override
  _CardPushState createState() => _CardPushState();
}

class _CardPushState extends State<CardPush> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      height: MediaQuery.of(context).size.height / 3.5,
      width: MediaQuery.of(context).size.width / 2,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 10,
        color: Colors.indigoAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text(
                "Barang Masuk/Keluar",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            InkWell(
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                title: Text(
                  "Barang Masuk",
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(Icons.add, color: Colors.white),
              ),
            ),
            InkWell(
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                title: Text(
                  "Barang Keluar",
                  style: TextStyle(color: Colors.white),
                ),
                leading: Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Curved extends StatefulWidget {
  @override
  _CurvedState createState() => _CurvedState();
}

class _CurvedState extends State<Curved> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: CurvedNavigationBar(
      height: 50,
      color: Colors.indigo,
      backgroundColor: Colors.white,
      buttonBackgroundColor: Colors.indigo,
      items: <Widget>[
        InkWell(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        InkWell(
          child: Icon(
            Icons.signal_cellular_connected_no_internet_4_bar,
            color: Colors.white,
          ),
        ),
        InkWell(
          child: Icon(
            Icons.find_in_page,
            color: Colors.white,
          ),
        ),
      ],
      animationCurve: Curves.easeInOutCubic,
      animationDuration: Duration(milliseconds: 600),
    ));
  }
}

class Drawerr extends StatefulWidget {
  @override
  _DrawerrState createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("MUMTAZ SHOP"),
            accountEmail: Text("alvan.doc@gmail.com"),
            currentAccountPicture: GestureDetector(
                child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            )),
            decoration: BoxDecoration(color: Colors.red),
          ),
          InkWell(
            child: ListTile(
              onTap: () {},
              title: Text("Tambah Data"),
              leading: Icon(Icons.add, color: Colors.redAccent),
            ),
          ),
          InkWell(
            child: ListTile(
              onTap: () {},
              title: Text("Barang Masuk"),
              leading: Icon(Icons.arrow_upward, color: Colors.redAccent),
            ),
          ),
          InkWell(
            child: ListTile(
              onTap: () {},
              title: Text("Barang Keluar"),
              leading: Icon(Icons.arrow_downward, color: Colors.redAccent),
            ),
          ),
          InkWell(
            child: ListTile(
              onTap: () {},
              title: Text("Kategori"),
              leading: Icon(
                Icons.dashboard,
                color: Colors.redAccent,
              ),
            ),
          ),
          InkWell(
            child: ListTile(
              onTap: () {},
              title: Text("Stock Barang"),
              leading: Icon(
                Icons.folder_open,
                color: Colors.redAccent,
              ),
            ),
          ),
          Divider(
            height: 80,
          ),
          InkWell(
            child: ListTile(
              onTap: () {},
              title: Text("Pengaturan"),
              leading: Icon(Icons.settings_applications),
            ),
          ),
          InkWell(
            child: ListTile(
              onTap: () {},
              title: Text("Tentang"),
              leading: Icon(
                Icons.help,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
