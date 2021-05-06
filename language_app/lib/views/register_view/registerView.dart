import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/view_models/userViewModel.dart';
import 'registerViewStyle.dart';
import 'package:language_app/services/userService.dart';
import 'package:language_app/components/popups/alertDialog.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
  final NavigationService _navigationService = locator<NavigationService>();
}

class _RegisterViewState extends State<RegisterView> {
  UserService _userService = UserService.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();

  Future<void> _register() async {
    String userOutput = await _userService.registerNewUser(emailController.text, passwordController.text, nameController.text, surnameController.text);
    print(userOutput);
    if (userOutput == "Success") {
      showAlertDialog(context, "Success", "Registration completed", "loginView");
    } else {
      showAlertDialog(context, "Ups! Something went wrong.", userOutput, null);
    }
  }


  @override
  Widget build(BuildContext context) {

    final TextFormField emailInput =
        TextInputComponent("Email", false, Icons.email, emailController);
    final TextFormField passwordInput =
        TextInputComponent("Password", true, Icons.lock, passwordController);
    final TextFormField nameInput =
        TextInputComponent("Name", false, Icons.account_circle_outlined, nameController);
    final TextFormField surnameInput =
        TextInputComponent("Surname", false, Icons.account_circle_outlined, surnameController);
    final Material registerButton = OnPressButton("Register", _register, context);
    final Widget label = forgotSignLabels(widget._navigationService);
    List<Widget> widgetList = [
      emailInput,
      passwordInput,
      nameInput,
      surnameInput,
      registerButton,
      label,
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Container(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [RegisterViewPadding(widgetList)]),
        ))),
      ),
    );
  }
}
