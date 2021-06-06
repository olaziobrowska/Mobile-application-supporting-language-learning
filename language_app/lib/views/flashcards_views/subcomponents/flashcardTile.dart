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
        child: Container(
          height: kTileHeight,
          decoration: kTileBoxDecoration,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(padding: const EdgeInsets.only(left: 10.0)),
              _code.isGroupCreator(_code.selectedGroup)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(padding: const EdgeInsets.only(top: 5.0)),
                        Icon(
                          Icons.check_circle,
                          size: 18.0,
                          color: Colors.green,
                        ),
                        const Padding(padding: const EdgeInsets.only(top: 2.0)),
                        Text(
                          _flashcard.positiveAnswers.toString(),
                          style: TextStyle(color: Colors.green, fontSize: 12.0),
                        ),
                        const Padding(padding: const EdgeInsets.only(top: 2.0)),
                      ],
                    )
                  : Container(),
              _code.isGroupCreator(_code.selectedGroup)
                  ? const Padding(padding: const EdgeInsets.only(left: 5.0))
                  : Container(),
              _code.isGroupCreator(_code.selectedGroup)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(padding: const EdgeInsets.only(top: 5.0)),
                        Icon(
                          Icons.cancel,
                          size: 18.0,
                          color: Colors.red,
                        ),
                        const Padding(padding: const EdgeInsets.only(top: 2.0)),
                        Text(
                          _flashcard.negativeAnswers.toString(),
                          style: TextStyle(color: Colors.red, fontSize: 12.0),
                        ),
                        const Padding(padding: const EdgeInsets.only(top: 2.0)),
                      ],
                    )
                  : Container(),
              _code.isGroupCreator(_code.selectedGroup)
                  ? const Padding(padding: const EdgeInsets.only(left: 20.0))
                  : Container(),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: leftTextPadding),
                  Text(
                    _flashcard.word + " - " + _flashcard.translatedWord,
                    overflow: TextOverflow.ellipsis,
                    style: kTileTextStyle,
                  )
                ],
              )),
              _code.isGroupCreator(_code.selectedGroup)
                  ? Row(
                      children: [
                        _code.generateGroupsOptions(_flashcard),
                        const Padding(padding: rightIconsPadding)
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
