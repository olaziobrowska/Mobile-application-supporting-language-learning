//List tile
import 'package:flutter/material.dart';

const kDrawerListTilePadding = EdgeInsets.only(left: 5);
const kDrawerListTileTextAlign = TextAlign.left;
final kDrawerListTileTextStyle = TextStyle(
  color: kDrawerListTileTextColor,
  fontWeight: FontWeight.normal,
  fontSize: 20,
);
final kDrawerListTileTextColor = Colors.white;
final kDrawerListTileLeadingPadding = EdgeInsets.only(left: 20);

const kBackgroundGradient = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.3, 0.8],
      colors: [Colors.lightBlueAccent, Colors.tealAccent]),
);

//header
final kDrawerUserNamesTextStyle = TextStyle(
  fontSize: 20,
  fontFamily: 'Lato',
  color: kDrawerTextColor,
);

final kDrawerEmailTextStyle = TextStyle(
  fontSize: 15,
  fontFamily: 'Lato',
  color: kDrawerTextColor,
);
final kDrawerHeaderBoxDecorationColor = Colors.lightBlueAccent;
final kDrawerHeaderBoxDecoration = BoxDecoration(color: kDrawerHeaderBoxDecorationColor);
//Text title
const kDrawerTextMainPadding = EdgeInsets.only(left: 15);
const kDrawerTextTextAlign = TextAlign.left;

final kDrawerTextStyle = TextStyle(
  color: kDrawerTextColor,
  fontWeight: FontWeight.normal,
  fontSize: 20,
);
final kDrawerTextColor = Colors.white;