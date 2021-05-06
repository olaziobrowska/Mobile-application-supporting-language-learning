import 'package:flutter/material.dart';

class ProgressView extends StatefulWidget {
  @override
  _ProgressViewState createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  List items = [];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Progress"),
          // backgroundColor: Colors.red[300],
          actions: <Widget>[
            // IconButton(
            //     icon: Icon(
            //       Icons.camera_alt_outlined,
            //       color: Colors.white,
            //     ),
            //     onPressed: () async {
            //       String photoScanResult = await scanner.scan();
            //       try {
            //         await widget._navigationService
            //             .navigateTo('wiki-page', int.parse(photoScanResult));
            //       } catch (err) {}
            //     })
          ],
        ),
        body: WillPopScope(
          // onWillPop: () {},
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
                          // onChanged: (value) {
                          //   filterSearchResults(value);
                          // },
                          // controller: editingController,
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Colors.grey.withOpacity(0.2),
                              filled: true,
                              // labelText: "Search",
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
                    Expanded(
                        child: IconButton(
                          // onPressed: _openFilterDialog,
                          tooltip: 'Increment',
                          icon: Icon(Icons.filter, color: Colors.blue[300]),
                        ))
                    // Icon(Icons.filter, color: Colors.red[300]))),
                  ],
                ),
                Expanded(
                    child: CustomScrollView(
                        slivers: <Widget>[
                          SliverGrid(
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 4 / 3,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0),
                              delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  return GestureDetector(
                                    child: new Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        // color: Colors.redAccent,
                                        child: Card()),
                                    onTap: () {}
                                  );
                                },
                                childCount: 5,

                              )
                          ),
                        ])
                ),
              ],
            ),
          ),
        ));
  }
}


class TestCard extends StatelessWidget {
  // Card({this.pokemon});
  //
  // final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 8, 8, 0),
              // child: Icon(),
            ),
          ],
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 1,
                // child: Image.network(pokemon.imageUrl)
        ),
              Expanded(
                  flex: 1,
                  child: Center(child: Text("CARD")
                  )),
            ],
          ),
        ),
      ]),
    );
  }
}