import 'package:flutter/material.dart';

//textstyles
TextStyle headerTextStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 26.0);
TextStyle inputTextStyle =
    TextStyle(fontFamily: 'Montserrat', fontSize: 16.0, color: Colors.white);

//paddings
const enterPadding = EdgeInsets.fromLTRB(15, 5, 15, 5);
const leftTextPadding = EdgeInsets.only(left: 50.0);

//texts
const kFlashcardGroupsTitle = "Word bank";
const kFlashcardsTitle = "Flashcards";

//colors
const kFloatingButtonBackgroundColor = Colors.white;
const kFloatingButtonIconColor = Colors.blueAccent;

//other
const kTileHeight = 50.0;
const kAppbarHeight = Size.fromHeight(50.0);
const kFloatingButtonSize = 50.0;
const kFloatingButtonIcon =
    Icon(Icons.add, color: kFloatingButtonIconColor, size: kFloatingButtonSize);
