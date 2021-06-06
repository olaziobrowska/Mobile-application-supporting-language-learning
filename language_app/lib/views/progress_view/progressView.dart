import 'package:flutter/material.dart';
import 'package:language_app/components/appbar/appbar.dart';
import 'package:language_app/components/drawer/drawer.dart';
import 'package:language_app/utils/global_const/globalLayout.dart';
import 'package:language_app/views/progress_view/progressModel.dart';
import 'package:provider/provider.dart';
import 'testCard.dart';
import 'testCardModel.dart';

class ProgressView extends StatefulWidget {
  ProgressView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ProgressViewState createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  final ProgressViewModel _progressViewModel = ProgressViewModel.instance;
  String searchValue = "";
  TextEditingController editingController = TextEditingController();

  var items = List<TestCardModel>();
  var filteredItems = List<TestCardModel>();

  @override
  void initState() {
    super.initState();
    update();
  }

  void update() async {
    await _progressViewModel.getTestsResults();
    setState(() {
      items = _progressViewModel.userTestCardModels;
    });
  }

  void filterSearchResults(String query) {
    setState(() {
      searchValue = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    filteredItems = items
        .where((item) =>
            item.name.toLowerCase().contains(searchValue.toLowerCase()))
        .toList();

    return ChangeNotifierProvider.value(
      value: _progressViewModel,
      child: Consumer<ProgressViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: MainAppBar(resultsTitle)),
          drawer: MainDrawer(),
          body: items.length > 0
                  ? WillPopScope(
                      child: Container(
                        margin: new EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      onChanged: (value) {
                                        filterSearchResults(value);
                                      },
                                      controller: editingController,
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.black),
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.withOpacity(0.2),
                                          filled: true,
                                          hintText: "Search",
                                          contentPadding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                          ),
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: Colors.blue[300],
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)))),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                                child: CustomScrollView(slivers: <Widget>[
                              SliverGrid(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          childAspectRatio: 12 / 3,
                                          crossAxisSpacing: 8.0,
                                          mainAxisSpacing: 8.0),
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return GestureDetector(
                                        child: new Card(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: TestCard(
                                                testCard: filteredItems[index])),
                                      );
                                    },
                                    childCount: filteredItems.length,
                                  )),
                            ])),
                          ],
                        ),
                      ),
                    )
                  : emptyResultsContainer())
        ),
      );
  }
}

Container emptyResultsContainer() {
  return Container(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Text("No test were taken yet")
          )
        ],
      ),
    ]),
  );
}
