import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import 'language.dart';

class HomeViewModel extends ChangeNotifier {
  String translatedWord;
  String inputWord = "";
  final translator = GoogleTranslator();
  String selectedLang1;
  String selectedLang2;

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

  setLang1(String value){
    selectedLang1 = value;
    notifyListeners();
  }
  setLang2(String value){
    selectedLang2 = value;
    notifyListeners();
  }

  translate() async {
    var translation = await translator.translate(
        inputWord,
        from: langValidator(selectedLang1),
        to: langValidator(selectedLang2));
    translatedWord = translation.text;
    notifyListeners();
  }

  String langValidator([String lang]) {
    if (lang != null) {
      return lang;
    } else {
      return 'auto';
    }
  }
}
