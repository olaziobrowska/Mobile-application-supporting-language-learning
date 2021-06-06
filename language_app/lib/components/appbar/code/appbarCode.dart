import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/services/userService.dart';
import 'package:language_app/utils/authorization/authenticationTools.dart';
import 'package:language_app/utils/local_storage/storage.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/views/home_view/homeViewModel.dart';

class AppbarCode extends ChangeNotifier {
  String text;
  List<String> appbarChoices = [
    AppStorage.loggedInUser.languageSelected ?? "No language",
    "Logout"
  ];

  final AuthenticationTools _auth = AuthenticationTools.instance;
  final NavigationService _navigationService = locator<NavigationService>();

  AppbarCode._({this.text});

  static AppbarCode New(String title) {
    return AppbarCode._(text: title);
  }

  onSelectedAppbarSideOption(String choice, BuildContext context) {
    switch (choice) {
      case "Logout":
        _auth.signOut();
        _navigationService.navigateAndReplaceAll("welcomeView");
        break;
      default:
        notifyListeners();
        break;
    }
  }

  buildAppbarChoices(BuildContext context) {
    return appbarChoices.map((String choice) {
      if (choice == "Logout") {
        return PopupMenuItem<String>(
          value: choice,
          child: Text(choice),
        );
      }
      else {
        return PopupMenuItem<String>(value: AppStorage.loggedInUser.languageSelected,
            child: DropdownButtonComponent(
                HomeViewModel.instance.buildLangItems(),
                    (value) {
                  AppStorage.loggedInUser.languageSelected = value;
                  UserService.instance.saveCachedUser();
                  loadChoices();
                  notifyListeners();
                  Navigator.pop(context);
                }, AppStorage.loggedInUser.languageSelected,false));
      }
    }).toList();
  }

  loadChoices() {
    appbarChoices = [
      AppStorage.loggedInUser.languageSelected ?? "No language",
      "Logout"
    ];
  }
}
