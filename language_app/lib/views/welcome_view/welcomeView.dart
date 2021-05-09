import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/utils/global_const/globalLayout.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/views/welcome_view/welcomeViewStyle.dart';

class WelcomeView extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    final Text welcomeText = textBanner(appTitle);
    final loginButton = OnPressButton("Login", () {
      _navigationService.navigateTo("loginView", 0);
    }, context);
    final registerButton = OnPressButton("Register", () {
      _navigationService.navigateTo("registerView", 0);
    }, context);
    final logoPath = "assets/images/placeholder.png";

    List<Widget> widgetList = [
      welcomeText,
      loginButton,
      registerButton,
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [WelcomeViewPadding(widgetList, logoPath)]),
        )),
      ),
    );
  }
}
