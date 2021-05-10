import 'dart:math';

import 'package:language_app/view_models/errorViewModel.dart';
import 'package:language_app/view_models/flashcards/flashcardGroupViewModel.dart';
import 'package:language_app/view_models/flashcards/flashcardTestQuestionViewModel.dart';
import 'package:language_app/view_models/flashcards/flashcardTestViewModel.dart';
import 'package:language_app/view_models/flashcards/flashcardViewModel.dart';

class FlashcardTestBuilder {
  static FlashcardTestViewModel buildForAll(
      List<FlashcardGroupViewModel> groups,
      int numberOfQuestions,
      int time,
      String type) {
    List<FlashcardViewModel> flashcards = [];
    groups.forEach((element) {
      flashcards.addAll(element.flashcards);
    });
    if (flashcards.length == 0)
      throw ErrorViewModel.newFromMessage("No flashcards selected!");
    List<FlashcardTestQuestionViewModel> questions = [];
    switch (type) {
      case 'ABCD':
        questions = _prepareABCDQuestions(numberOfQuestions, flashcards);
        break;
      case 'Text':
        questions = _prepareTextQuestions(numberOfQuestions, flashcards);
        break;
      default:
        throw ErrorViewModel.newFromMessage("Test type not supported!");
    }
    return FlashcardTestViewModel.New(type, time, questions);
  }

  static FlashcardTestViewModel buildForFlashcardGroup(
      FlashcardGroupViewModel groupViewModel,
      int numberOfQuestions,
      int time,
      String type) {
    if (groupViewModel == null || groupViewModel.flashcards.length == 0)
      throw ErrorViewModel.newFromMessage("No flashcards selected!");
    List<FlashcardTestQuestionViewModel> questions = [];
    switch (type) {
      case 'ABCD':
        questions =
            _prepareABCDQuestions(numberOfQuestions, groupViewModel.flashcards);
        break;
      case 'Text':
        questions =
            _prepareTextQuestions(numberOfQuestions, groupViewModel.flashcards);
        break;
      default:
        throw ErrorViewModel.newFromMessage("Test type not supported!");
    }
    return FlashcardTestViewModel.New(type, time, questions);
  }

  static List<FlashcardTestQuestionViewModel> _prepareABCDQuestions(
      int numberOfQuestions, List<FlashcardViewModel> flashcardViewModel) {
    var testingFlashcards = flashcardViewModel;
    List<FlashcardTestQuestionViewModel> output = [];
    for (int i = 0; i < numberOfQuestions; i++) {
      Random _rnd = Random();
      FlashcardViewModel flashcardToTest =
      testingFlashcards[_rnd.nextInt(testingFlashcards.length)];
      List<String> answers = List.of([flashcardToTest.translatedWord]);
      List<FlashcardViewModel> otherFlashcards = testingFlashcards
          .where((element) => element.id != flashcardToTest.id).toList();
      testingFlashcards = otherFlashcards;
      if (flashcardViewModel.length < 4) {
        answers.addAll(otherFlashcards.map((e) => e.translatedWord));
        for (var j = 0; j < 4 - answers.length; j++) {
          answers.add(_randomWordsToFillABCD[
              _rnd.nextInt(_randomWordsToFillABCD.length)]);
        }
      } else {
        List<int> indexesTaken = [];
        for (var j = 0; j < 3; j++) {
          var randomIndex;
          while(true){
             randomIndex = _rnd.nextInt(flashcardViewModel.length);
            if(!indexesTaken.contains(randomIndex)){
              indexesTaken.add(randomIndex);
              break;
            }
          }
          answers.add(flashcardViewModel[randomIndex]
              .translatedWord);
        }
      }
      answers.shuffle();
      output.add(FlashcardTestQuestionViewModel.newForFlashcard(
          flashcardToTest, answers));
    }
    return output;
  }

  static List<FlashcardTestQuestionViewModel> _prepareTextQuestions(
      int numberOfQuestions, List<FlashcardViewModel> flashcardViewModel) {
    List<FlashcardTestQuestionViewModel> output = [];
    for (int i = 0; i < numberOfQuestions; i++) {
      Random _rnd = Random();
      FlashcardViewModel flashcardToTest =
          flashcardViewModel[_rnd.nextInt(flashcardViewModel.length)];
      List<FlashcardViewModel> otherFlashcards = flashcardViewModel
          .where((element) => element.id != flashcardToTest.id);
      flashcardViewModel = otherFlashcards;
      output.add(
          FlashcardTestQuestionViewModel.newForFlashcard(flashcardToTest, []));
    }
    return output;
  }

  static List<String> _randomWordsToFillABCD = [
    "Pachucho",
    "Qingzhe",
    "Tram",
    "Bountiful",
    "Quaraqorum",
    "Wu"
  ];
}
