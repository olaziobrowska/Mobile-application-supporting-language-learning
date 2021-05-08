import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import 'language.dart';

class HomeViewModel extends ChangeNotifier {
  String translatedWord;
  String inputWord;
  final translator = GoogleTranslator();
  Language targetLanguage;
  Language sourceLanguage;

  HomeViewModel._();

  static final HomeViewModel instance = HomeViewModel._();

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
