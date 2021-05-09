import 'dart:math';

import 'package:language_app/view_models/flashcards/flashcardTestQuestionViewModel.dart';

class FlashcardTestViewModel {
  String id;
  String testType;
  bool timeLimited;
  int time;
  int correctAnswers;
  List<FlashcardTestQuestionViewModel> questions;

  FlashcardTestViewModel._(
      {this.id,
      this.testType,
      this.timeLimited,
      this.time,
      this.correctAnswers,
      this.questions});

  static FlashcardTestViewModel New(
      String type, int time, List<FlashcardTestQuestionViewModel> questions) {
    return FlashcardTestViewModel._(
        testType: type,
        timeLimited: time != 0,
        questions: questions,
        correctAnswers: 0,
        time: time,
        id: _generateRandomID());
  }

  static String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static Random _rnd = Random();

  static _generateRandomID() => String.fromCharCodes(Iterable.generate(
      25, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
