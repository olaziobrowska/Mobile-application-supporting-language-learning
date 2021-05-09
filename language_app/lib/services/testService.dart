import 'package:language_app/models/flashcards/flashcardTestResultModel.dart';
import 'package:language_app/repositories/testResultRepository.dart';
import 'package:language_app/services/flashcardService.dart';
import 'package:language_app/services/flashcardTestBuilder.dart';
import 'package:language_app/utils/local_storage/storage.dart';
import 'package:language_app/view_models/errorViewModel.dart';
import 'package:language_app/view_models/flashcards/flashcardGroupViewModel.dart';
import 'package:language_app/view_models/flashcards/flashcardTestResultViewModel.dart';
import 'package:language_app/view_models/flashcards/flashcardTestViewModel.dart';
import 'package:language_app/view_models/flashcards/flashcardViewModel.dart';

class TestService {
  TestService._();

  static final TestService instance = TestService._();

  final FlashcardService _flashcardService = FlashcardService.instance;
  final TestResultRepository _repository = TestResultRepository.instance;

  FlashcardTestViewModel startNewTest(int time,
      String type,
      int numberOfQuestions,
      List<FlashcardGroupViewModel> selectedGroup,
      bool buildForAll) {
    if (selectedGroup == null || selectedGroup.length == 0)
      throw ErrorViewModel.newFromMessage("No flashcards selected!");
    try {
      if (buildForAll)
        return FlashcardTestBuilder.buildForAll(
            selectedGroup, numberOfQuestions, time, type);
      else
        return FlashcardTestBuilder.buildForFlashcardGroup(
            selectedGroup[0], numberOfQuestions, time, type);
    } catch (e) {
      throw e;
    }
  }

  Future<void> submitTestResults(FlashcardTestViewModel testViewModel) async {
    var score = testViewModel.questions
        .where((element) => element.correctAnswer)
        .length;
    List<FlashcardViewModel> flashcards;
    List<String> flashcardIDs = testViewModel.questions.map((e) => e.flashcardID).toList();
    flashcards = await _flashcardService.getFlashcardsInIDs(flashcardIDs);
    _updateFlashcardsResults(flashcards, testViewModel);
    for(var flashcard in flashcards){
      await _flashcardService.changeFlashcard(flashcard);
    }
    var result = FlashcardTestResultViewModel.newFlashcardTest(
        AppStorage.loggedInUser, score, testViewModel.questions.length);
    await _repository.addNewTestResult(FlashcardTestResultModel.newFromViewModel(result));
  }

  Future<List<FlashcardTestResultViewModel>> getUsersTestResults() async {
    try{
      var result = await _repository.getUsersTestResults();
      List<FlashcardTestResultViewModel> output = [];
      for(var model in result){
        output.add(FlashcardTestResultViewModel.newFromModel(model));
      }
      return output;
    } catch(e) {
      throw e;
    }
  }

  _updateFlashcardsResults(List<FlashcardViewModel> flashcards, FlashcardTestViewModel testViewModel) {
    flashcards.forEach((elem) { 
      var question = testViewModel.questions.singleWhere((element) => element.flashcardID == elem.id);
      if(question.correctAnswer) elem.positiveAnswers++;
      else elem.negativeAnswers++;
    });
  }
}
