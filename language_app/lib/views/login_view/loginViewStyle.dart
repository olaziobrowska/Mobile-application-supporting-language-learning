import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonComponents.dart';

Padding LoginViewPadding(List<Widget> widgetList, String imagePath) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 25.0),
        SizedBox(
          height: 250.0,
          child: InsertImage(imagePath)
        ),
        SizedBox(height: 25.0),
        widgetList[0],
        SizedBox(height: 20.0),
        widgetList[1],
        SizedBox(height: 30.0,),
        widgetList[2],
        SizedBox(height: 10.0,),
        widgetList[3],
      ],
    ),
  );
}
