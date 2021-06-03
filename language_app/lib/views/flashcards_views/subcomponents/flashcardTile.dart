import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/view_models/flashcards/flashcardViewModel.dart';
import 'package:language_app/views/flashcards_views/code/flashcardsViewsCode.dart';
import 'package:language_app/views/flashcards_views/code/flashcardsViewsStyle.dart';

class FlashcardTile extends StatelessWidget {
  FlashcardViewModel _flashcard;

  FlashcardTile(this._flashcard);

  final FlashcardsViewsCode _code = FlashcardsViewsCode.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: enterPadding,
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          height: kTileHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding: leftTextPadding),
                      Text(_flashcard.word + " - " + _flashcard.translatedWord)
                    ],
                  )),
              _code.isGroupCreator(_code.selectedGroup) ? Row(
                children: [
                  _code.generateGroupsOptions(_flashcard),
                  const Padding(padding: rightIconsPadding)
                ],
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }
}
