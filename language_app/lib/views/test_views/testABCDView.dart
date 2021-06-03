import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/components/appbar/appbar.dart';
import 'package:language_app/components/drawer/drawer.dart';
import 'package:language_app/views/test_views/code/testViewCode.dart';
import 'package:provider/provider.dart';

import 'code/testViewStyle.dart';

class TestABCDView extends StatefulWidget {
  static final String id = "flashcardView";

  TestABCDView({Key key}) : super(key: key);

  @override
  _TestABCDViewState createState() => _TestABCDViewState();
}

class _TestABCDViewState extends State<TestABCDView> {
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
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 10.0)),
                          Expanded(
                              flex: 10,
                              child: Row(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10.0)),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10.0)),
                                ],
                              )),
                          const Padding(padding: EdgeInsets.only(top: 10.0)),
                          Expanded(
                              flex: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Center(
                                        child: Text(_code
                                            .createdTest
                                            .questions[
                                                _code.currentQuestionIndex]
                                            .wordToTranslate)),
                                  )
                                ],
                              )),
                          const Padding(padding: EdgeInsets.only(top: 10.0)),
                          Expanded(
                              flex: 35,
                              child: Row(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10.0)),
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(),
                                        color: _code.selectedIndex == 0
                                            ? _code.answerColor
                                            : null),
                                    child: InkWell(
                                      onTap: () async {
                                        await _code.answerABCDQuestion(0,context);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(_code
                                              .createdTest
                                              .questions[
                                                  _code.currentQuestionIndex]
                                              .answers[0])
                                        ],
                                      ),
                                    ),
                                  )),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10.0)),
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(),
                                        color: _code.selectedIndex == 1
                                            ? _code.answerColor
                                            : null),
                                    child: InkWell(
                                      onTap: () async {
                                        await _code.answerABCDQuestion(1,context);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(_code
                                              .createdTest
                                              .questions[
                                                  _code.currentQuestionIndex]
                                              .answers[1])
                                        ],
                                      ),
                                    ),
                                  )),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10.0)),
                                ],
                              )),
                          const Padding(padding: EdgeInsets.only(top: 10.0)),
                          Expanded(
                              flex: 35,
                              child: Row(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10.0)),
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(),
                                        color: _code.selectedIndex == 2
                                            ? _code.answerColor
                                            : null),
                                    child: InkWell(
                                      onTap: () async {
                                        await _code.answerABCDQuestion(2,context);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(_code
                                              .createdTest
                                              .questions[
                                                  _code.currentQuestionIndex]
                                              .answers[2])
                                        ],
                                      ),
                                    ),
                                  )),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10.0)),
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(),
                                        color: _code.selectedIndex == 3
                                            ? _code.answerColor
                                            : null),
                                    child: InkWell(
                                      onTap: () async {
                                        await _code.answerABCDQuestion(3,context);
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(_code
                                              .createdTest
                                              .questions[
                                                  _code.currentQuestionIndex]
                                              .answers[3])
                                        ],
                                      ),
                                    ),
                                  )),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10.0)),
                                ],
                              )),
                          const Padding(padding: EdgeInsets.only(top: 10.0)),
                        ],
                      )
                    ],
                  ),
                )));
  }
}
