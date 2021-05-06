import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/components/common/commonStyles.dart';
import 'package:language_app/utils/routes/routes.dart';

Padding LoginViewPadding(List<Widget> widgetList, String imagePath) {
  return Padding(
    padding: const EdgeInsets.all(36.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 30.0),
        SizedBox(
          height: 300.0,
          child: InsertImage(imagePath)
        ),
        SizedBox(height: 30.0),
        widgetList[0],
        SizedBox(height: 25.0),
        widgetList[1],
        SizedBox(height: 35.0,),
        widgetList[2],
        SizedBox(height: 15.0,),
        widgetList[3],
      ],
    ),
  );
}

Row forgotSignLabels(NavigationService _navigationService) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      FlatButton(
        padding: EdgeInsets.all(0.0),
        child: Text("Don't have an account?",
            style: hiperLinkTextStyle),
        onPressed: () {
          _navigationService.navigateTo("registerView", 0);
        },
      ),
      FlatButton(
        padding: EdgeInsets.only(left: 0.0),
        child: Text("Forgot password?", style: hiperLinkTextStyle),
        onPressed: () {
          _navigationService.navigateTo("resetPasswordView", 0);
        },
      ),
    ],
  );
}