import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:language_app/components/common/commonComponents.dart';

String lessonId ="1";

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
        Text("Lesson " + lessonId, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 15.0)),
        widgetList[0],
        SizedBox(height: 10.0),
        TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                labelText: 'Your note',
                helperText:
                    'Enter the text and then accept with the submit button',
                hintText: 'Please enter notes',
                prefixIcon:
                    const Icon(FontAwesomeIcons.bookOpen, color: Colors.teal),
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)))),
        SizedBox(height: 10.0),
        widgetList[1],
        SizedBox(height: 25.0),
        MaterialButton(
          onPressed: () {},
          color: Colors.blue,
          textColor: Colors.white,
          child: Icon(
            Icons.add,
            size: 24,
          ),
          padding: EdgeInsets.all(16),
          shape: CircleBorder(),
        )
      ],
    ),
  );
}
