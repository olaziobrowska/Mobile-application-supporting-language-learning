import 'package:flutter/cupertino.dart';
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
}
