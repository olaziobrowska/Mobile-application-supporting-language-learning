import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/components/appbar/appbar.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/components/drawer/drawer.dart';
import 'package:provider/provider.dart';

import 'code/testViewCode.dart';
import 'code/testViewStyle.dart';

class TestTextView extends StatefulWidget {
  static final String id = "flashcardView";

  TestTextView({Key key}) : super(key: key);

  @override
  _TestTextViewState createState() => _TestTextViewState();
}

class _TestTextViewState extends State<TestTextView> {
  final TestViewsCode _code = TestViewsCode.instance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: _code,
        child: Consumer<TestViewsCode>(
            builder: (context, code, child) => Scaffold(
                  appBar: PreferredSize(
                    preferredSize: kAppbarHeight,
                    child: MainAppBar(kAppbarSetupTitle),
                  ),
                  drawer: MainDrawer(),
                  body: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _code.alreadyAnswered
                              ? Text(
                                  _code.resultText,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: _code.answerColor, fontSize: 25),
                                )
                              : Container(),
                          Padding(padding: const EdgeInsets.only(top: 15.0)),
                          Text(
                              _code
                                  .createdTest
                                  .questions[_code.currentQuestionIndex]
                                  .wordToTranslate,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 25)),
                          Padding(padding: const EdgeInsets.only(top: 25.0)),
                          TextInputComponent2(
                              'Type your answer', false, Icons.check_circle,
                              (value) {
                            _code.answerTyped = value;
                          }, TextEditingController(text: _code.answerTyped)),
                          Padding(padding: const EdgeInsets.only(top: 35.0)),
                          OnPressButton("Answer", () {
                            _code.answerTextQuestion(context);
                          }, context)
                        ],
                      )
                    ],
                  ),
                )));
  }
}
