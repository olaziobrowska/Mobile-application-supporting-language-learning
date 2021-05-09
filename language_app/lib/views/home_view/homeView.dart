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

  @override
  Widget build(BuildContext context) {
    final textControllerIn =
        TextEditingController(text: _homeViewModel.inputWord);
    final inputWord =
        TextInputComponent2("Enter your text", false, null, (val) {
      _homeViewModel.inputWord = val;
    }, textControllerIn);
    final logoPath = "assets/images/placeholder.png";
    final translateButton = OnPressButton("Translate", () async {
      await _homeViewModel.translate();
    }, context);
    final createFlashcardButton = OnPressButton("Create Flashcard", () {
      widget._navigationService
          .navigateTo("Flashcards", 1); //TODO nawigacja do FlashCard
    }, context);
    List<Widget> widgetList = [
      inputWord,
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
                            _homeViewModel.setLang1(val);
                          }, _homeViewModel.selectedLang1),
                          SizedBox(height: height1),
                          widgetList[0],
                          SizedBox(height: height1),
                          DropdownButtonComponent(
                              HomeViewModel.instance.buildLangItems(), (val) {
                            _homeViewModel.setLang2(val);
                          }, _homeViewModel.selectedLang2),
                          SizedBox(height: height1),
                          TextOutputComponent(
                              "Translation",
                              false,
                              null,
                              TextEditingController(
                                  text: _homeViewModel.translatedWord)),
                          SizedBox(height: height3),
                          widgetList[1],
                          SizedBox(height: height1),
                          widgetList[2]
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
