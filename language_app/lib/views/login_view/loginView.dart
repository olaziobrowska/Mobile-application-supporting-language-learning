import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'loginViewStyle.dart';

class LoginView extends StatefulWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  LoginView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  void _navigateToRegister() {
    widget._navigationService.navigateTo('registerView', 0);
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextInputComponent("Email", false, null);
    final passwordField = TextInputComponent("Password", true, null);
    final loginButton = OnPressButton("Login", () {
      widget._navigationService.navigateTo("homeView", 1);
    }, context);
    final registerButton =
        LinkFlatButton("Don't have an account?", _navigateToRegister);
    final logoPath = "assets/images/placeholder.png";

    List<Widget> widgetList = [
      emailField,
      passwordField,
      loginButton,
      registerButton
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Container(
                child: Form(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [LoginViewPadding(widgetList, logoPath)]),
        ))),
      ),
    );
  }
}
