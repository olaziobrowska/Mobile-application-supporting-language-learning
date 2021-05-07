import 'package:flutter/material.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'testCard.dart';
import 'testCardModel.dart';

class ProgressView extends StatefulWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  // TODO
  // final Function getUserTests; or something like that
  // ProgressView({@required this.getUserTests});

  @override
  _ProgressViewState createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  String searchValue = "";
  bool loading = true;

  TextEditingController editingController = TextEditingController();

  var items = List<TestCardModel>();
  var filteredItems = List<TestCardModel>();
  List<String> selectedCountList = [];

  TestCardModel someTestCard1 =
      TestCardModel(1, "Some test name", 99); // to remove
  TestCardModel someTestCard2 =
      TestCardModel(2, "Another test", 32); // to remove

  @override
  void initState() {
    super.initState();
    items.add(someTestCard1); // to remove
    items.add(someTestCard2); // to remove
    // TODO
    // getUserTests(); or something like that
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
