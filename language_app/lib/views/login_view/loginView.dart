import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/components/popups/alertDialog.dart';
import 'package:language_app/services/userService.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/view_models/userViewModel.dart';
import 'loginViewStyle.dart';

class LoginView extends StatefulWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  LoginView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  UserService _userService = UserService.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _navigateToRegister() {
    widget._navigationService.navigateTo('registerView', 0);
  }

  Future<void> logIn() async {
    List loginResults = await _userService.logIn(emailController.text, passwordController.text);
    if (loginResults[1] == "Success") {
      UserViewModel u = await _userService.getLoggedInUser();
      showAlertDialog(context, "Success", "Hello " + u.name, null);
      // route to navigate
      //widget._navigationService.navigateTo('REPLACE_ME', 0);
    } else {
      showAlertDialog(context, "Ups! Something went wrong.", loginResults[0], null);
    }
  }

  @override
  Widget build(BuildContext context) {

    final emailField = TextInputComponent("Email", false, null, emailController);
    final passwordField = TextInputComponent("Password", true, null, passwordController);
    final loginButton = OnPressButton("Login", logIn, context);
    // final registerButton =
    //     LinkFlatButton("Don't have an account?", _navigateToRegister);
    final registerButton = forgotSignLabels(widget._navigationService);
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
