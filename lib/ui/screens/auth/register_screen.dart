import 'package:flutter/material.dart';
import 'package:project_ta_ke_7/core/models/auth_model.dart';
import 'package:project_ta_ke_7/core/utils/dialog_utils.dart';
import 'package:project_ta_ke_7/core/utils/hash_utils.dart';
import 'package:project_ta_ke_7/core/viewmodels/auth/auth_provider.dart';
import 'package:project_ta_ke_7/ui/constant/constant.dart';
import 'package:project_ta_ke_7/ui/widget/input_widget.dart';
import 'package:project_ta_ke_7/ui/widget/primary_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterBody(),
    );
  }
}

class RegisterBody extends StatefulWidget {

  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  void createUser() {
    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty
      && emailController.text.isNotEmpty && nameController.text.isNotEmpty
      && phoneController.text.isNotEmpty) {

        //* Creating data
        var register = RegisterModel(
          username: usernameController.text,
          password: HashUtils.instance.hash(passwordController.text),
          email: emailController.text,
          name: nameController.text,
          phone: phoneController.text
        );

        Provider.of<AuthProvider>(context, listen: false).create(register, context);
    } else {
      DialogUtils.instance.showInfo(context, 
        "Silahkan isi semua bagian terlebih dahulu", 
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
              _titleWidget(),
              SizedBox(height: 40),
              _fieldUsername(),
              SizedBox(height: 10),
              _fieldPassword(),
              SizedBox(height: 10),
              _fieldEmail(),
              SizedBox(height: 10),
              _fieldName(),
              SizedBox(height: 10),
              _fieldPhone(),
              SizedBox(height: 30),
              _buttonLogin(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return Column(
      children: <Widget>[
        Text(
          "Sign up",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Colors.black87
          ),
        ),
        Text(
          "Create your account here",
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

  Widget _fieldEmail() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Email Address",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15)
            ),
            SizedBox(height: 10),
            InputWidget(
              controller: emailController,
              action: TextInputAction.done,
              type: TextInputType.emailAddress,
              hintText: "Enter your email address.",
            )
          ],
        );
      },
    );
  }

  Widget _fieldName() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Name",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15)
            ),
            SizedBox(height: 10),
            InputWidget(
              controller: nameController,
              action: TextInputAction.done,
              type: TextInputType.text,
              hintText: "Enter your name",
            )
          ],
        );
      },
    );
  }

  Widget _fieldPhone() {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Nomor Ponsel",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15)
            ),
            SizedBox(height: 10),
            InputWidget(
              controller: phoneController,
              action: TextInputAction.done,
              type: TextInputType.number,
              hintText: "Enter your phone number",
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

  Widget _buttonLogin() {
    return PrimaryButton(
      text: "Sign Up",
      color: primaryColor,
      onPress: () => createUser(),
    );
  }

}