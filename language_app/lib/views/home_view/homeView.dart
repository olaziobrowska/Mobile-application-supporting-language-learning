import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/utils/global_const/globalLayout.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/views/home_view/homeViewModel.dart';
import 'package:provider/provider.dart';

import 'homeViewStyle.dart';

class HomeView extends StatefulWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  HomeView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final HomeViewModel _homeViewModel = HomeViewModel.instance;

  @override
  Widget build(BuildContext context) {
    final inputWord = TextInputComponent("Enter your text", false, null);
    final translatedWord = TextInputComponent("Translation", false, null);
    final logoPath = "assets/images/placeholder.png";

    List<Widget> widgetList = [inputWord, translatedWord];

    return ChangeNotifierProvider.value(
      value: _homeViewModel,
      child: Scaffold(
        appBar: new AppBar(
          title: Text(appTitle,
              style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
                  child: Form(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [HomeViewPadding(widgetList, logoPath)]),
          ))),
        ),
      ),
    );
  }
}
