import 'package:flutter/material.dart';

import 'code/appbarCode.dart';
import 'code/appbarStyle.dart';

class MainAppBar extends StatelessWidget {
  final AppbarCode code;
  MainAppBar({this.code});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          Text(code.text, style: appbarTextStyle, textAlign: TextAlign.center),
      centerTitle: true,
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: (choice) {
            code.onSelectedAppbarSideOption(choice, context);
          },
          itemBuilder: (BuildContext context) {
            return code.buildAppbarChoices(context);
          },
        )
      ],
      flexibleSpace: Container(
        decoration: appBarBoxStyle,
      ),
    );
  }
}
