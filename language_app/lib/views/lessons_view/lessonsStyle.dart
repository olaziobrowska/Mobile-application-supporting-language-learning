import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonComponents.dart';

final List<String> entries = <String>['1', '2', '3'];
final List<int> colorCodes = <int>[300, 200, 100];

Padding LessonsViewPadding(List<Widget> widgetList, String imagePath) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10.0),
        SizedBox(height: 250.0, child: InsertImage(imagePath)),
        SizedBox(height: 10.0),
        Container(
          width: 300,
          height: 300,
          child: Scrollbar(
            child: ListView.separated(
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return new GestureDetector(
                  onTap: () => print(entries[index]),
                  child: new Card(
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          height: 50,
                          color: Colors.blue[colorCodes[index]],
                          child:
                              Center(child: Text('Lesson ${entries[index]}')),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        widgetList[0],
      ],
    ),
  );
}
