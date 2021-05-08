import 'package:flutter/material.dart';
import 'package:language_app/components/appbar/appbar.dart';
import 'package:language_app/components/appbar/code/appbarCode.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/components/drawer/drawer.dart';
import 'package:language_app/utils/global_const/globalLayout.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:provider/provider.dart';

import 'lessonsModel.dart';
import 'lessonsStyle.dart';

class LessonsView extends StatefulWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  LessonsView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LessonsViewState createState() => _LessonsViewState();
}

class _LessonsViewState extends State<LessonsView> {
  final LessonsViewModel _lessonsViewModel = LessonsViewModel.instance;

  @override
  Widget build(BuildContext context) {
    final logoPath = "assets/images/book5.png";
    final addLessonButton = OnPressButton("Add lesson", () {
      widget._navigationService.navigateTo("homeView", 1);
    }, context);
    List<Widget> widgetList = [addLessonButton];

    return ChangeNotifierProvider.value(
      value: _lessonsViewModel,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: MainAppBar(code: AppbarCode.New(lessonsTitle))),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
                  child: Form(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [LessonsViewPadding(widgetList, logoPath)]),
                  ))),
        ),
      ),
    );
  }
}
