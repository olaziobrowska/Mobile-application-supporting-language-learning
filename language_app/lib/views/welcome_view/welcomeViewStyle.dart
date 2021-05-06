import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonComponents.dart';

Padding WelcomeViewPadding(List<Widget> widgetList, String imagePath) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 35.0),
        widgetList[0],
        SizedBox(height: 24.0),
        SizedBox(
            height: 250.0,
            child: InsertImage(imagePath)
        ),
        SizedBox(height: 27.0),
        widgetList[1],
        SizedBox(height: 15.0),
        widgetList[2],

      ],
    ),
  );
}