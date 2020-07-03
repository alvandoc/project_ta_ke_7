import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/viewmodels/auth/auth_provider.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashBody(),
    );
  }
}

class SplashBody extends StatefulWidget {
  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {


  void initSession() async {
    await Future.delayed(Duration(seconds: 3)).then((value) {
      Provider.of<AuthProvider>(context, listen: false).checkSession(context);
    });
  }

  @override
  void initState() {
    super.initState();
    this.initSession();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context),
      height: deviceHeight(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _logoWidget(),
          _titleWidget()
        ],
      ),
    );
  }


  Widget _logoWidget() {
    return Container(
      width: deviceWidth(context),
      height: 150,
      child: Image.asset("${iconAsset}/logo.png"),
    );
  }

  Widget _titleWidget() {
    return Column(
      children: <Widget>[
        Text(
          "My Inventory",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w700,
            color: Colors.black87
          ),
        )
      ],
    );
  }
}