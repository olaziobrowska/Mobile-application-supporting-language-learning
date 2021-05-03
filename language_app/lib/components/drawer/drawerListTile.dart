import 'package:flutter/material.dart';

import 'code/drawerStyle.dart';

class DrawerListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;

  DrawerListTile({this.text, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: kDrawerListTilePadding,
        child: Text(text,
            textAlign: kDrawerListTileTextAlign,
            style: kDrawerListTileTextStyle),
      ),
      leading: Padding(
        padding: kDrawerListTileLeadingPadding,
        child: Icon(
          icon,
          color: kDrawerListTileTextColor,
        ),
      ),
      onTap: onTap,
    );
  }
}