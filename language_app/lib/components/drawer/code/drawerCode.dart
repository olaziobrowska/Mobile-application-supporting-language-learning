import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/view_models/userViewModel.dart';

import '../drawerListTile.dart';
import 'drawerStyle.dart';

class DrawerCode extends ChangeNotifier {
  final NavigationService _navigationService = locator<NavigationService>();

  DrawerCode._();

  static final DrawerCode instance = DrawerCode._();

  List<DrawerListTile> getListTiles() {
    return [
      DrawerListTile(
          text: "Home",
          icon: FontAwesomeIcons.home,
          onTap: () {
            _navigationService.navigateTo("homeView", []);
          }),
      DrawerListTile(
          text: "Flashcards",
          icon: FontAwesomeIcons.language,
          onTap: () {
            _navigationService.navigateTo("Flashcards", []);
          }),
      DrawerListTile(
          text: "Lessons",
          icon: FontAwesomeIcons.school,
          onTap: () {
            _navigationService.navigateTo("lessonsView", []);
          }),
      DrawerListTile(
          text: "Notes",
          icon: FontAwesomeIcons.clipboard,
          onTap: () {
            _navigationService.navigateTo("notesView", []);
          })
    ];
  }

  Widget buildDrawerAccountHeader(
      BuildContext buildContext, UserViewModel user) {
    return UserAccountsDrawerHeader(
        accountName: displayFullName(buildContext, user),
        accountEmail: user.email == null
            ? Container()
            : Text("${user.email}", style: kDrawerEmailTextStyle),
        decoration: kDrawerHeaderBoxDecoration);
  }

  Widget displayFullName(BuildContext context, UserViewModel user) {
    return Text(
      user.names(),
      style: kDrawerUserNamesTextStyle,
    );
  }
}
