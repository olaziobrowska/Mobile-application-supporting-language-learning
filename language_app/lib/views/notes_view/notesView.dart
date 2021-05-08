import 'package:flutter/material.dart';
import 'package:language_app/components/appbar/appbar.dart';
import 'package:language_app/components/appbar/code/appbarCode.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/components/drawer/drawer.dart';
import 'package:language_app/utils/global_const/globalLayout.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/views/notes_view/notesModel.dart';
import 'package:provider/provider.dart';

import 'notesStyle.dart';

class NotesView extends StatefulWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  NotesView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  final NotesViewModel _notesViewModel = NotesViewModel.instance;

  @override
  Widget build(BuildContext context) {
    final inputWord = TextInputComponent("Title", false, null);
    final logoPath = "assets/images/paper1.png";
    final submitButton = OnPressButton("Submit", () {
      widget._navigationService.navigateTo("homeView", 1);
    }, context);

    List<Widget> widgetList = [
      inputWord,
      submitButton,
    ];

    return ChangeNotifierProvider.value(
      value: _notesViewModel,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: MainAppBar(code: AppbarCode.New(notesTitle))),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
                  child: Form(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [NotesViewPadding(widgetList, logoPath)]),
          ))),
        ),
      ),
    );
  }
}
