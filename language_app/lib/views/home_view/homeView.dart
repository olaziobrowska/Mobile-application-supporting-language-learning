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

//TODO zrobić zapamiętanie z jakiego języka na jaki się tłumaczy poki co jest tylko ang
//TODO podpiąć pod translateButton logikę?????
//TODO refactor gdzie co dać + wyniesienie DropDown
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
  String selectedLang1 = 'en'; //todo zmienic
  String selectedLang2 = 'en';

  @override
  Widget build(BuildContext context) {
    final inputWord = TextInputComponent("Enter your text", false, null);
    final translatedWord = TextOutputComponent("Translation", false, null);
    final logoPath = "assets/images/placeholder.png";
    final translateButton = OnPressButton("Translate", () {
      _homeViewModel.translator
          .translate("car is pretty", from: 'en', to: 'pl')
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
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: MainAppBar(code: AppbarCode.New(appTitle))),
        drawer: MainDrawer(),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
                  child: Form(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height1),
                    SizedBox(height: imageHeight, child: InsertImage(logoPath)),
                    SizedBox(height: height2),
                    DropdownButton(
                      underline: SizedBox(),
                      hint: Text('Please choose language'),
                      icon: Icon(
                        Icons.language,
                        color: Colors.blueAccent,
                      ),
                      items: HomeViewModel.instance.buildLangItems(),
                      onChanged: (val) {
                        setState() {
                          selectedLang1 = val;
                        }
                      },
                      value: selectedLang1,
                    ),
                    SizedBox(height: height1),
                    widgetList[0],
                    SizedBox(height: height1),
                    DropdownButton(
                      underline: SizedBox(),
                      hint: Text('Please choose language'),
                      icon: Icon(
                        Icons.language,
                        color: Colors.blueAccent,
                      ),
                      items: HomeViewModel.instance.buildLangItems(),
                      onChanged: (val) {
                        print(val);
                        setState() {
                          selectedLang2 = val;
                        }
                      },
                      value: selectedLang2,
                    ),
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
    );
  }
}
