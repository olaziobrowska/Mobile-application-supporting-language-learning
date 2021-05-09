import 'package:flutter/material.dart';

//text
final appbarTextStyle = TextStyle(fontSize: 34);

final appBarBoxStyle = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [1.0, 0.0],
        colors: [firstGradientColor, secondGradientColor]));

final firstGradientColor = Colors.lightBlueAccent;
final secondGradientColor = Colors.tealAccent;