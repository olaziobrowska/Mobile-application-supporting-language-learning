import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/views/flashcards_views/code/flashcardsViewsCode.dart';
import 'package:language_app/views/flashcards_views/code/flashcardsViewsStyle.dart';
import 'package:uiblock/uiblock.dart';

class FlashcardAddSheet extends StatefulWidget {
  @override
  _FlashcardAddSheetState createState() => _FlashcardAddSheetState();
}

class _FlashcardAddSheetState extends State<FlashcardAddSheet> {
  final FlashcardsViewsCode _code = FlashcardsViewsCode.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.8],
                colors: [Colors.grey, Colors.blueGrey]),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                16.0, 8.0, 16.0, MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                Text('Enter new flashcard:', style: headerTextStyle),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextField(
                          controller: TextEditingController(
                              text: _code.newFlashcardWordInput),
                          maxLength: 40,
                          autofocus: true,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            _code.newFlashcardWordInput = value;
                          },
                          style: inputTextStyle,
                          decoration:
                          buildInputDecoration("Word", Icons.arrow_forward),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10.0)),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextField(
                          controller: TextEditingController(
                              text: _code.newFlashcardTranslatedInput),
                          maxLength: 40,
                          autofocus: true,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            _code.newFlashcardTranslatedInput = value;
                          },
                          style: inputTextStyle,
                          decoration:
                          buildInputDecoration("Translation", Icons.arrow_forward),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20.0)),
                    InkWell(
                      onTap: () async {
                        UIBlock.block(context);
                        await _code.addNewFlashcard();
                        UIBlock.unblock(context);
                      },
                      child: Container(
                          width: 80,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Color(0xff01A0C7),
                          ),
                          child: Center(
                              child: Text(
                                'Add',
                                style: inputTextStyle,
                                textAlign: TextAlign.center,
                              ))),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20.0))
              ],
            ),
          )),
    );
  }
}
