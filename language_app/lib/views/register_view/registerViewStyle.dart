import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonStyles.dart';
import 'package:language_app/utils/routes/routes.dart';

Row forgotSignLabels(NavigationService _navigationService) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      FlatButton(
        padding: EdgeInsets.all(0.0),
        child: Text("Forgot password?",
          style: hiperLinkTextStyle),
        onPressed: () {},
      ),
      FlatButton(
        padding: EdgeInsets.only(left: 0.0),
        child: Text("Sign in", style: hiperLinkTextStyle),
        onPressed: () {
          _navigationService.navigateTo("loginView", 0);
        },
      ),
    ],
  );
}

Padding RegisterViewPadding(List<Widget> widgetList) {
  return Padding(
    padding: const EdgeInsets.all(36.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 100.0),
        Text("Email"),
        SizedBox(height: 5.0),
        widgetList[0],
        SizedBox(height: 15.0),
        Text("Password"),
        SizedBox(height: 5.0),
        widgetList[1],
        SizedBox(height: 15.0),
        Text('Name'),
        SizedBox(height: 5.0),
        widgetList[2],
        SizedBox(height: 15.0),
        Text('Surname'),
        SizedBox(height: 5.0),
        widgetList[3],
        SizedBox(height: 50.0),
        widgetList[4],
        SizedBox(height: 5.0),
        widgetList[5],
      ],
    ),
  );
}
