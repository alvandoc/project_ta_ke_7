import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/utils/dialog_utils.dart';
import 'package:project_ta_ke_7/core/utils/hash_utils.dart';
import 'package:project_ta_ke_7/core/viewmodels/auth/auth_provider.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';
import 'package:project_ta_ke_7/ui/router/router_generator.dart';
import 'package:project_ta_ke_7/ui/widget/input_widget.dart';
import 'package:project_ta_ke_7/ui/widget/primary_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(),
    );
  }
}

class LoginBody extends StatefulWidget {

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  void login() {
    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      Provider.of<AuthProvider>(context, listen: false).login(
        usernameController.text, 
        HashUtils.instance.hash(passwordController.text), context);
    } else {
      DialogUtils.instance.showInfo(context, 
        "Username dan password tidak boleh kosong", 
        Icons.error, "OK");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: deviceWidth(context),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _logoWidget(),
              _titleWidget(),
              SizedBox(height: 40),
              _fieldUsername(),
              SizedBox(height: 10),
              _fieldPassword(),
              SizedBox(height: 30),
              _buttonCreate(),
              SizedBox(height: 20),
              _registerTitle()
            ],
          ),
        ),
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
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Colors.black87
          ),
        ),
        Text(
          "Please enter credentials",
          style: TextStyle(
            fontSize: 13,
            color: Colors.black45
          ),
        ),
      ],
    );
  }

  Widget _fieldUsername() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Username",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15)
            ),
            SizedBox(height: 10),
            InputWidget(
              controller: usernameController,
              action: TextInputAction.done,
              type: TextInputType.text,
              hintText: "Enter your username",
            )
          ],
        );
      },
    );
  }

  Widget _fieldPassword() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Password",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15)
            ),
            SizedBox(height: 10),
            InputWidget(
              controller: passwordController,
              action: TextInputAction.done,
              type: TextInputType.text,
              secureText: true,
              maxLine: 1,
              hintText: "Enter your password",
            )
          ],
        );
      },
    );
  }

  Widget _buttonCreate() {
    return PrimaryButton(
      text: "Sign In",
      color: primaryColor,
      onPress: () => login(),
    );
  }

  Widget _registerTitle() {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RouterGenerator.routeRegister),
      child: Text(
        "Belum punya akun? Daftar sekarang!",
        style: TextStyle(
          fontSize: 13,
          color: Colors.black54
        ),
      ),
    );
  }
}