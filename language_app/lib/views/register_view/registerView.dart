import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'registerViewStyle.dart';

class RegisterView extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    final TextField emailInput =
        TextInputComponent("Email", false, Icons.email);
    final TextField passwordInput =
        TextInputComponent("Password", false, Icons.lock);
    final TextField nameInput =
        TextInputComponent("Name", false, Icons.account_circle_outlined);
    final TextField surnameInput =
        TextInputComponent("Surname", false, Icons.account_circle_outlined);
    final Material registerButton = OnPressButton("Register", () {}, context);
    final Row label = forgotSignLabels(_navigationService);
    List<Widget> widgetList = [
      emailInput,
      passwordInput,
      nameInput,
      surnameInput,
      registerButton,
      label
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
