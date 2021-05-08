import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/views/home_view/homeViewModel.dart';

String selectedLang = 'en'; //todo zmienic

Padding NotesViewPadding(List<Widget> widgetList, String imagePath) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10.0),
        SizedBox(height: 250.0, child: InsertImage(imagePath)),
        SizedBox(height: 10.0),
        widgetList[0],
        SizedBox(height: 10.0),
        DropdownButton(
          underline: SizedBox(),
          hint: Text('Please choose language'),
          icon: Icon(
            Icons.language,
            color: Colors.blueAccent,
          ),
          items: HomeViewModel.instance.buildLangItems(),
          onChanged: (val) {
            print(val);
          },
          value: selectedLang,
        ),
        SizedBox(height: 10.0),
        TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                hintText: 'Please input some notes',
                labelText: 'Your note',
                prefixIcon: const Icon(FontAwesomeIcons.bookOpen, color: Colors.teal),
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)))),

        SizedBox(height: 10.0),
        widgetList[1],
        SizedBox(height: 25.0)
      ],
    ),
  );
}
