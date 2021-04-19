import 'package:flutter/material.dart';

TextStyle textStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
EdgeInsets inputPadding = EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0);
TextStyle hiperLinkTextStyle = TextStyle(color: Colors.blue, fontSize: 15);
Color iconColor = Color.fromRGBO(50, 62, 72, 1.0);
TextStyle textBannerStyle = TextStyle(
  fontSize: 50.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
  letterSpacing: -1.0,
  wordSpacing: 5.0,
  shadows: [
    Shadow(
      blurRadius: 15.0,
      color: Colors.blue,
      offset: Offset(5.0, 5.0),
    ),
  ],
);