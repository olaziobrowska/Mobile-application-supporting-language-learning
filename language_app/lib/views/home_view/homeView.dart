import 'package:flutter/material.dart';
import 'package:language_app/components/appbar/appbar.dart';
import 'package:language_app/components/appbar/code/appbarCode.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/components/drawer/drawer.dart';
import 'package:language_app/utils/global_const/globalLayout.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/views/home_view/homeViewModel.dart';
import 'package:provider/provider.dart';

import 'homeViewStyle.dart';

//TODO podpiąć pod translateButton logikę
//TODO podpięcie create flashcards

class HomeView extends StatefulWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  HomeView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _homeViewModel = HomeViewModel.instance;
  String selectedLang1;
  String selectedLang2;
  final textControllerIn = TextEditingController();
  final textControllerOut = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textControllerIn.dispose();
    super.dispose();
  }

  String langValidator([String lang]) {
    if (lang != null) {
      return lang;
    } else {
      return 'auto';
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputWord =
        TextInputComponent("Enter your text", false, null, textControllerIn);
    final translatedWord =
        TextOutputComponent("Translation", false, null, textControllerOut);
    final logoPath = "assets/images/placeholder.png";
    final translateButton = OnPressButton("Translate", () {
      _homeViewModel.translator
          .translate(textControllerIn.text,
              from: langValidator(selectedLang1),
              to: langValidator(selectedLang2))
          .then(print);
    }, context);
    final createFlashcardButton = OnPressButton("Create Flashcard", () {
      widget._navigationService
          .navigateTo("Flashcards", 1); //TODO nawigacja do FlashCard
    }, context);
    List<Widget> widgetList = [
      inputWord,
      translatedWord,
      translateButton,
      createFlashcardButton
    ];

    return ChangeNotifierProvider.value(
      value: _homeViewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: MainAppBar(code: AppbarCode.New(appTitle))),
          drawer: MainDrawer(),
          body: SingleChildScrollView(
            child: Center(
                child: Container(
                    child: Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: height1),
                          SizedBox(
                              height: imageHeight,
                              child: InsertImage(logoPath)),
                          SizedBox(height: height2),
                          DropdownButtonComponent(
                              HomeViewModel.instance.buildLangItems(), (val) {
                            setState(() {
                              selectedLang1 = val;
                            });
                          }, selectedLang1),
                          SizedBox(height: height1),
                          widgetList[0],
                          SizedBox(height: height1),
                          DropdownButtonComponent(
                              HomeViewModel.instance.buildLangItems(), (val) {
                            setState(() {
                              selectedLang2 = val;
                            });
                          }, selectedLang2),
                          SizedBox(height: height1),
                          widgetList[1],
                          SizedBox(height: height3),
                          widgetList[2],
                          SizedBox(height: height1),
                          widgetList[3]
                        ],
                      ),
                    )
                  ]),
            ))),
          ),
        ),
      ),
    );
  }
}
