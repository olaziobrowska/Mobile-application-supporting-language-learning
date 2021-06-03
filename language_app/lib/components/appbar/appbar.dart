import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'code/appbarCode.dart';
import 'code/appbarStyle.dart';

class MainAppBar extends StatefulWidget {
  AppbarCode _code;
  MainAppBar(String appBarText){
    _code = AppbarCode.New(appBarText);
  }

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget._code,
      child: Consumer<AppbarCode>(
          builder: (context, viewModel, child) => AppBar(
                title: Text(widget._code.text,
                    style: appbarTextStyle, textAlign: TextAlign.center),
                centerTitle: true,
                actions: <Widget>[
                  PopupMenuButton<String>(
                    onSelected: (choice) {
                      widget._code.onSelectedAppbarSideOption(choice, context);
                    },
                    itemBuilder: (BuildContext context) {
                      return widget._code.buildAppbarChoices(context);
                    },
                  )
                ],
                flexibleSpace: Container(
                  decoration: appBarBoxStyle,
                ),
              )),
    );
  }
}
