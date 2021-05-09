import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/view_models/flashcards/flashcardGroupViewModel.dart';
import 'package:language_app/views/flashcards_views/code/flashcardsViewsCode.dart';
import 'package:language_app/views/flashcards_views/code/flashcardsViewsStyle.dart';

class FlashcardGroupTile extends StatelessWidget {
  FlashcardGroupViewModel group;

  FlashcardGroupTile(this.group);

  final FlashcardsViewsCode _code = FlashcardsViewsCode.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: enterPadding,
      child: InkWell(
        onTap: () => _code.navigateToFlashcards(group),
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
                  Text(group.name)
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
