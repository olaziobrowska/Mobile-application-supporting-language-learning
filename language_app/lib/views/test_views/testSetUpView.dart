import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/components/appbar/appbar.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/components/drawer/drawer.dart';
import 'package:language_app/views/test_views/code/testViewCode.dart';
import 'package:provider/provider.dart';

import 'code/testViewStyle.dart';

class TestSetUpView extends StatefulWidget {
  static final String id = "flashcardView";

  TestSetUpView({Key key}) : super(key: key);

  @override
  _TestSetUpViewState createState() => _TestSetUpViewState();
}

class _TestSetUpViewState extends State<TestSetUpView> {
  final TestViewsCode _code = TestViewsCode.instance;

  @override
  void initState() {
    super.initState();
    _code.fetchUserFlashcardGroups();
  }

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
                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 20.0)),
                        Text('Test type:')
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                              title: const Text('ABCD'),
                              value: "ABCD",
                              groupValue: _code.selectedTestType,
                              onChanged: (val) {
                                _code.updateTestTypeSelect(val);
                              }),
                        ),
                        Expanded(child: RadioListTile(
                            title: const Text('Text input'),
                            value: "Text",
                            groupValue: _code.selectedTestType,
                            onChanged: (val) {
                              _code.updateTestTypeSelect(val);
                            }))
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              RadioListTile(
                                  title: const Text('All'),
                                  value: "All",
                                  groupValue: _code.selectedType,
                                  onChanged: (val) {
                                    _code.updateTypeSelect(val);
                                  }),
                              RadioListTile(
                                  title: const Text('Group'),
                                  value: "Group",
                                  groupValue: _code.selectedType,
                                  onChanged: (val) {
                                    _code.updateTypeSelect(val);
                                  })
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: DropdownButton(
                              underline: SizedBox(),
                              hint: Text('Select group'),
                              icon: Icon(
                                Icons.select_all,
                                color: Colors.blueAccent,
                              ),
                              items: _code.buildLangItems(),
                              onChanged: _code.selectedType == 'All'
                                  ? null
                                  : (val) {
                                      _code.updateSelectedGroup(val);
                                    },
                              value: _code.selectedGroup,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 20.0)),
                        Text('Amount of questions:')
                      ],
                    ),
                    Row(
                      children: [Expanded(
                        flex: 10,
                        child: Slider(
                                    value: _code.selectedItemsAmount.toDouble(),
                                    min: 0,
                                    max: _code.maxItems.toDouble(),
                                    divisions: _code.maxItems == 0 ? null : _code.maxItems,
                                      label: _code.selectedItemsAmount.toString(),
                                    onChanged: (value){
                                      _code.updateSelectedAmountOfItems(value);
                                    },
                                  ),
                      ),
                                Expanded(
                                    child: Text(
                                      _code.selectedItemsAmount.toString()),
                                )
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 20.0)),
                        Text('Time limit (0 for no time limit):')
                      ],
                    ),
                    Row(
                      children: [Expanded(
                        flex: 10,
                        child: Slider(
                          value: _code.selectedTimeAmount.toDouble(),
                          min: 0,
                          max: _code.maxTime.toDouble(),
                          divisions: _code.maxTime,
                          label: _code.selectedTimeAmount.toString(),
                          onChanged: (value){
                            _code.updateSelectedAmountOfTime(value);
                          },
                        ),
                      ),
                        Expanded(
                          child: Text(
                              _code.selectedTimeAmount.toString()),
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 15.0)),
                    OnPressButton('Start!',() => _code.startTest(),context)
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
