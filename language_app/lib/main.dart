import 'package:flutter/material.dart';
import 'package:language_app/services/userService.dart';
import 'package:language_app/utils/local_storage/storage.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final String email = prefs.getString('email');
  if(email != null){
    AppStorage.loggedInUser = await UserService.instance.getLoggedInUser();
  }
  runApp(App(email: email));
}