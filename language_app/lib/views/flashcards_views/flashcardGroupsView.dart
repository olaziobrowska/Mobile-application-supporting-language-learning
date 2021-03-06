import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/components/appbar/appbar.dart';
import 'package:language_app/components/appbar/code/appbarCode.dart';
import 'package:language_app/components/drawer/drawer.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/views/flashcards_views/code/flashcardsViewsCode.dart';
import 'package:language_app/views/flashcards_views/subcomponents/flashGroupAddSheet.dart';
import 'package:language_app/views/flashcards_views/subcomponents/flashcardGroupTile.dart';
import 'package:provider/provider.dart';

import 'code/flashcardsViewsStyle.dart';

class FlashcardGroupsView extends StatefulWidget {
  static final String id = "flashcardGroupsView";

  FlashcardGroupsView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FlashcardGroupsViewState createState() => _FlashcardGroupsViewState();
}

class _FlashcardGroupsViewState extends State<FlashcardGroupsView>{
  final FlashcardsViewsCode _code = FlashcardsViewsCode.instance;
  @override
  void initState() {
    super.initState();
    _code.fetchUserFlashcardGroups();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _code,
      child: Consumer<FlashcardsViewsCode>(
        builder: (context,code,child) => Scaffold(
          appBar: PreferredSize(
            preferredSize: kAppbarHeight,
            child: MainAppBar(code: AppbarCode.New(kFlashcardGroupsTitle)),
          ),
          drawer: MainDrawer(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: kFloatingButtonBackgroundColor,
            child: kFloatingButtonIcon,
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return FlashcardGroupAddSheet();
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
                      itemCount: _code.usersGroups.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context,index) {
                      return FlashcardGroupTile(_code.usersGroups[index]);
                  })
                  ]
            )]
            ),
          ),
        ),
      );
  }
  
}