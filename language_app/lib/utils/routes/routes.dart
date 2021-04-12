import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => NavigationService());
}

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateToReplace(String routeName, Object args) {
    return navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: args);
  }

  Future<dynamic> navigateTo(String routeName, Object args) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: args);
  }
}
