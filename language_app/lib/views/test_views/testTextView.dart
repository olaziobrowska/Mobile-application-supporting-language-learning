import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/components/appbar/appbar.dart';
import 'package:language_app/components/appbar/code/appbarCode.dart';
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
                child: MainAppBar(code: AppbarCode.New(kAppbarSetupTitle)),
              ),
              drawer: MainDrawer(),
              body: Stack(
                children: [
                  Column(

                  )
                ],
              ),
            )
        )
    );
  }

}