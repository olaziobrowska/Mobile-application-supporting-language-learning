import 'package:flutter/material.dart';
import 'package:language_app/components/inputs/auth_inputs/authInput.dart';

import 'loginViewStyle.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final emailField = TextInputComponent("Email", false);
    final passwordField = TextInputComponent("Password", true);
    final loginButton = OnPressButton("Login", () {}, context);
    final logoPath = "assets/logo.png";

    List<Widget> widgetList = [emailField, passwordField, loginButton];

    return Scaffold(
      body: Center(
        child: Container(
            color: Colors.white, child: LoginViewPadding(widgetList, logoPath)),
      ),
    );
  }
}
