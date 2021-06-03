import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/view_models/flashcards/flashcardGroupViewModel.dart';
import 'package:language_app/views/flashcards_views/code/flashcardsViewsCode.dart';
import 'package:language_app/views/flashcards_views/code/flashcardsViewsStyle.dart';

class FlashcardGroupTile extends StatelessWidget {
  FlashcardGroupViewModel group;
  bool isPublicGroupsView;

  FlashcardGroupTile(this.group, this.isPublicGroupsView);

  final FlashcardsViewsCode _code = FlashcardsViewsCode.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: enterPadding,
      child: InkWell(
        onTap: () => _code.navigateToFlashcards(group),
        child: Container(
          height: kTileHeight,
          decoration: kTileBoxDecoration,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(padding: const EdgeInsets.only(left: 10.0)),
              Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(padding: leftTextPadding),
                      Text(group.name, style: kTileTextStyle, overflow: TextOverflow.ellipsis,),
                      isPublicGroupsView
                          ? Row(
                              children: [
                                const Padding(padding: secondLeftTextPadding),
                                Text(
                                  group.authorNames,
                                  style: subItemTextStyle,
                                )
                              ],
                            )
                          : Container(),
                    ],
                  )),
              Row(
                children: [
                  _code.isGroupCreator(group)
                      ? InkWell(
                          onTap: () {
                            _code.changeGroupPublicity(group);
                          },
                          child: kPublicGroupIcon(group.public),
                        )
                      : Container(),
                  !_code.isGroupCreator(group)
                      ? InkWell(
                          onTap: () {
                            _code.downloadPublicGroup(group);
                          },
                          child: kDownloadGroupIcon
                        )
                      : Container(),
                  const Padding(padding: rightIconsPadding),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
