import 'package:flutter/material.dart';
import 'package:language_app/utils/authorization/authenticationTools.dart';
import 'package:language_app/utils/routes/routes.dart';

class AppbarCode {
  final String text;
  final List<String> appbarChoices = ["Logout"];

  final AuthenticationTools _auth = AuthenticationTools.instance;
  final NavigationService _navigationService = locator<NavigationService>();
  AppbarCode._({this.text});

  static AppbarCode New(String title){
    return AppbarCode._(text:title);
  }

  onSelectedAppbarSideOption(String choice, BuildContext context) {
    switch (choice) {
      case "Logout":
        _auth.signOut();
        _navigationService.navigateAndReplaceAll("welcomeView");
        break;
    }
  }

  buildAppbarChoices(BuildContext context){
    return appbarChoices.map((String choice) {
      return PopupMenuItem<String>(
        value: choice,
        child: Text(choice),
      );
    }).toList();
  }
}