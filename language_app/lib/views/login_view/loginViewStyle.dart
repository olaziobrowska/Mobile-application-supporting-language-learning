import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonComponents.dart';

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
