import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonComponents.dart';

class Languagee {
  final int id;
  final String name;
  final String languageCode;

  const Languagee(this.id, this.name, this.languageCode);
}

const List<Languagee> getLanguages = <Languagee>[
  Languagee(1, 'English', 'en'),
  Languagee(2, 'فارسی', 'fa'),
  Languagee(3, 'پشتو', 'ps'),
];

Padding HomeViewPadding(List<Widget> widgetList, String imagePath) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 25.0),
        SizedBox(height: 250.0, child: InsertImage(imagePath)),
        SizedBox(height: 25.0),
        widgetList[0],
        SizedBox(height: 10.0),
        DropdownButton(
          underline: SizedBox(),
          hint: Text('Please choose language'),
          icon: Icon(
            Icons.language,
            color: Colors.blueAccent,
          ),
          items: getLanguages.map((Languagee lang) {
            return new DropdownMenuItem<String>(
              value: lang.languageCode,
              child: new Text(lang.name),
            );
          }).toList(),
          onChanged: (val) {
            print(val);
          },
        ),
        SizedBox(height: 10.0),
        widgetList[1],
        SizedBox(height: 25.0),
        widgetList[2]
      ],
    ),
  );
}
