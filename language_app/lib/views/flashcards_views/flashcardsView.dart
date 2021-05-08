import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/components/appbar/appbar.dart';
import 'package:language_app/components/appbar/code/appbarCode.dart';
import 'package:language_app/components/drawer/drawer.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/views/flashcards_views/code/flashcardsViewsCode.dart';
import 'package:language_app/views/flashcards_views/code/flashcardsViewsStyle.dart';
import 'package:language_app/views/flashcards_views/subcomponents/flashGroupAddSheet.dart';
import 'package:language_app/views/flashcards_views/subcomponents/flashcardGroupTile.dart';
import 'package:provider/provider.dart';

import 'subcomponents/flashcardAddSheet.dart';
import 'subcomponents/flashcardTile.dart';

class FlashcardView extends StatefulWidget {
  static final String id = "flashcardView";
  final NavigationService _navigationService = locator<NavigationService>();

  FlashcardView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FlashcardViewState createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView>{
  final FlashcardsViewsCode _code = FlashcardsViewsCode.instance;
  @override
  void initState() {
    super.initState();
    _code.fetchGroupFlashcards();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _code,
      child: Consumer<FlashcardsViewsCode>(
        builder: (context,code,child) => Scaffold(
          appBar: PreferredSize(
            preferredSize: kAppbarHeight,
            child: MainAppBar(code: AppbarCode.New(kFlashcardsTitle(_code.selectedGroup.name))),
          ),
          drawer: MainDrawer(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: kFloatingButtonBackgroundColor,
            child: kFloatingButtonIcon,
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return FlashcardAddSheet();
              },
            ),
          ),
          body: Stack(
              children: [
                Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListView.builder(
                          itemCount: _code.displayedFlashcards.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context,index) {
                            return FlashcardTile(_code.displayedFlashcards[index]);
                          })
                    ]
                )]
          ),
        ),
      ),
    );
  }

}