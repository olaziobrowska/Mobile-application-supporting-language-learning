import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/components/appbar/appbar.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/components/drawer/drawer.dart';
import 'package:language_app/views/test_views/subcomponents/timerBar.dart';
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
  void dispose() {
    _code.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textEditingComponent = TextEditingController(text: _code.answerTyped);
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
                      _code.selectedTestType == "Text" ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(padding: const EdgeInsets.only(top: 10.0)),
                          TimerBar(_code.time, _code.selectedTimeAmount.toDouble()),
                          const Padding(padding: const EdgeInsets.only(top: 10.0)),
                          Expanded(child: Container()),
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
                          }, textEditingComponent),
                          Padding(padding: const EdgeInsets.only(top: 35.0)),
                          OnPressButton("Answer", () {
                            _code.answerTextQuestion(context);
                            textEditingComponent.text = "";
                          }, context),
                          Expanded(child: Container()),
                        ],
                      ): Container()
                    ] ,
                  ),
                )));
  }
}
