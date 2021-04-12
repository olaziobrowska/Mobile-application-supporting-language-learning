import 'package:flutter/material.dart';

Image InsertImage(String imagePath) {
  return Image.asset(imagePath, fit: BoxFit.contain);
}

Padding LoginViewPadding(List<Widget> widgetList, String imagePath) {
  return Padding(
    padding: const EdgeInsets.all(36.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 155.0,
          child: InsertImage(imagePath)
        ),
        SizedBox(height: 45.0),
        widgetList[0],
        SizedBox(height: 25.0),
        widgetList[1],
        SizedBox(height: 35.0,),
        widgetList[2],
        SizedBox(height: 15.0,),
      ],
    ),
  );
}
