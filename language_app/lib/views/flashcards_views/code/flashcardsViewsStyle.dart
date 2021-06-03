import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//textstyles
TextStyle headerTextStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 26.0);
TextStyle inputTextStyle =
    TextStyle(fontFamily: 'Montserrat', fontSize: 16.0, color: Colors.white);
TextStyle itemTextStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 16,color: Colors.white);
TextStyle subItemTextStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 12,color: Colors.white);

//paddings
const enterPadding = EdgeInsets.fromLTRB(15, 5, 15, 5);
const leftTextPadding = EdgeInsets.only(left: 50.0);
const secondLeftTextPadding = EdgeInsets.only(left: 20.0);
const rightIconsPadding = EdgeInsets.only(right: 10.0);

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
const kMoveFlashcardIcon = Icon(
    FontAwesomeIcons.arrowsAlt,
    size: 20.0,
    color: Colors.white,
);
const kDownloadGroupIcon = Icon(
    Icons.download,
    color: Colors.white,
    size: 25.0,
);
kPublicGroupIcon(bool public) => Icon(
    public ? Icons.star : Icons.star_border,
    color: Colors.white,
    size: 25.0,
);
