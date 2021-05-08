import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/views/home_view/language.dart';
import 'package:translator/translator.dart';

class NotesViewModel extends ChangeNotifier {
  String translatedWord;
  String inputWord;
  final translator = GoogleTranslator();
  Language targetLanguage;
  Language sourceLanguage;

  NotesViewModel._();

  static final NotesViewModel instance = NotesViewModel._();

/*  translate() {
    notifyListeners();
  }*/

  List<DropdownMenuItem<dynamic>> buildLangItems() {
    List<DropdownMenuItem<dynamic>> output = [];
    for (var item in LanguageList.languages.entries) {
      var build = new DropdownMenuItem<String>(value: item.key,
          child: new Text(item.value));
      output.add(build);
    }
    return output;
  }
}
