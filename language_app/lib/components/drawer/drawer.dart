import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/components/drawer/code/drawerStyle.dart';
import 'package:language_app/components/drawer/drawerListTile.dart';
import 'package:language_app/utils/local_storage/storage.dart';

import 'code/drawerCode.dart';

class MainDrawer extends StatelessWidget {
  final DrawerCode _code = DrawerCode.instance;
  List<DrawerListTile> tiles;

  @override
  Widget build(BuildContext context) {
    tiles = _code.getListTiles();
    return Drawer(
        child: Stack(
      children: [
        Container(decoration: kBackgroundGradient),
        SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              AppStorage.loggedInUser != null
                  ? _code.buildDrawerAccountHeader(
                      context, AppStorage.loggedInUser)
                  : Container(),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: tiles.length,
                itemBuilder: (context, itemIndex) {
                  return tiles[itemIndex];
                },
              )
            ],
          ),
        ) //TODO: STYLE!
      ],
    ));
  }
}
