import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/services/testService.dart';
import 'package:language_app/view_models/flashcards/flashcardTestResultViewModel.dart';
import 'package:language_app/views/progress_view/testCardModel.dart';

class ProgressViewModel extends ChangeNotifier {
  ProgressViewModel._();

  static final ProgressViewModel instance = ProgressViewModel._();

  final TestService _service = TestService.instance;
  List<FlashcardTestResultViewModel> userTestResults = [];
  List<TestCardModel> userTestCardModels = [];

  Future<void> getTestsResults() async {
    List<TestCardModel> models = [];
    userTestResults = await _service.getUsersTestResults();
    userTestResults.forEach((element) {
        models.add(TestCardModel.fromTestResult(element));
      });
    userTestCardModels = models;
    notifyListeners();
  }
}
