import 'package:flutter/material.dart';
import 'package:language_app/services/testService.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'testCard.dart';
import 'testCardModel.dart';

class ProgressView extends StatefulWidget {

  @override
  _ProgressViewState createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  String searchValue = "";
  bool loading = true;

  TextEditingController editingController = TextEditingController();

  var items = List.of({new TestCardModel("ssda", "Raz", 51)});
  var filteredItems = List<TestCardModel>();
  List<String> selectedCountList = [];

  @override
  void initState() {
    super.initState();
    List<TestCardModel> models = [];
    TestService.instance.getUsersTestResults().then((value) {
      value.forEach((element) {
        models.add(TestCardModel.fromTestResult(element));
      });
      updateItems(models);
    }
    );
  }

  void updateItems(List<TestCardModel> models){
    if(models.isEmpty) models.add(new TestCardModel("ssda", "Raz", 51));
    setState(() {
      items = models;
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
    filteredItems = filteredItems.where((item) {
      if (selectedCountList.isEmpty) {
        return true;
      }
      return false;
    }).toList();

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Progress"),
        ),
        body: WillPopScope(
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
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)))),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: CustomScrollView(slivers: <Widget>[
                  SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                child:
                                    TestCard(testCard: filteredItems[index])),
                            onTap: () async {
                              // TODO
                              // await widget._navigationService
                              //     .navigateTo('REPLACE_ME_WITH_TEST_VIEW_URL', filteredItems[index].id);
                            },
                          );
                        },
                        childCount: filteredItems.length,
                      )),
                ])),
              ],
            ),
          ),
        ));
  }
}
