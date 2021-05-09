import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/components/popups/alertDialog.dart';
import 'package:language_app/services/flashcardService.dart';
import 'package:language_app/services/testService.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/view_models/errorViewModel.dart';
import 'package:language_app/view_models/flashcards/flashcardGroupViewModel.dart';
import 'package:language_app/view_models/flashcards/flashcardTestViewModel.dart';
import 'package:uiblock/uiblock.dart';

class TestViewsCode extends ChangeNotifier {
  TestViewsCode._();

  static final TestViewsCode instance = TestViewsCode._();

  final FlashcardService _flashcardService = FlashcardService.instance;
  final TestService _service = TestService.instance;
  final NavigationService _navigationService = locator<NavigationService>();

  String selectedTestType = "ABCD";
  String selectedType = "All";
  List<FlashcardGroupViewModel> userGroups = [];
  FlashcardGroupViewModel selectedGroup;
  int selectedItemsAmount = 0;
  int selectedTimeAmount = 15;

  int maxItems = 0;
  int minTime = 0;
  int maxTime = 45;
  int allFlashcards = 0;

  FlashcardTestViewModel createdTest;

  int currentQuestionIndex = 0;
  int selectedIndex = 5;
  Color answerColor = Colors.red;

  bool errorOccurred = false;
  String errorMessage = "";

  startTest() {
    var groups = selectedType == "All" ? userGroups : List.of({selectedGroup});
    createdTest = _service.startNewTest(selectedTimeAmount, selectedTestType,
        selectedItemsAmount, groups, selectedType == "All");
    var nextRoute =
    selectedTestType == "ABCD" ? "abcdTestView" : "textTestView";
    _navigationService.navigateTo(nextRoute, []);
  }

  updateTestTypeSelect(String value) {
    selectedTestType = value;
    notifyListeners();
  }

  updateTypeSelect(String value) {
    selectedType = value;
    _updateItems();
    notifyListeners();
  }

  updateSelectedGroup(FlashcardGroupViewModel selection) {
    selectedGroup = selection;
    maxItems = selectedGroup.flashcards.length;
    notifyListeners();
  }

  updateSelectedAmountOfItems(double value) {
    selectedItemsAmount = value.toInt();
    notifyListeners();
  }

  updateSelectedAmountOfTime(double value) {
    selectedTimeAmount = value.toInt();
    notifyListeners();
  }

  Future<void> fetchUserFlashcardGroups() async {
    try {
      userGroups = await _flashcardService.getUsersFlashcardGroups();
      allFlashcards = 0;
      userGroups.forEach((element) {
        allFlashcards += element.flashcards.length;
      });
      _updateItems();
    } on ErrorViewModel catch (e) {
      errorOccurred = true;
      errorMessage = e.message;
    } catch (e) {
      errorOccurred = true;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  List<DropdownMenuItem<dynamic>> buildLangItems() {
    List<DropdownMenuItem<dynamic>> output = [];
    for (var item in userGroups) {
      var build = new DropdownMenuItem<FlashcardGroupViewModel>(
          value: item, child: new Text(item.name));
      output.add(build);
    }
    return output;
  }

  answerABCDQuestion(int answerIndex, BuildContext context) async {
    selectedIndex = answerIndex;
    if (createdTest.questions[currentQuestionIndex].answers[answerIndex] ==
        createdTest.questions[currentQuestionIndex].answer) {
      createdTest.correctAnswers++;
      createdTest.questions[currentQuestionIndex].correctAnswer = true;
      answerColor = Colors.green;
    }
    else {
      answerColor = Colors.red;
    }
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));

    selectedIndex = 5;
    if (currentQuestionIndex >= createdTest.questions.length - 1)
      await endTest(context);
    else{
      currentQuestionIndex++;
      notifyListeners();
    }

  }

  endTest(BuildContext context) async {
    UIBlock.block(context);
    await _service.submitTestResults(createdTest);
    UIBlock.unblock(context);
    var correctAnswers = createdTest.correctAnswers;
    var incorrectAnswers = createdTest.questions.length - correctAnswers;
    showAlertDialog(context, "Test completed",
        "Test completed and results have been saved. \nCorrect answers: $correctAnswers\nIncorrect answers: $incorrectAnswers",
        "testView");
  }

  _updateItems() {
    switch (selectedType) {
      case 'All':
        maxItems = allFlashcards;
        if (selectedItemsAmount < maxItems) selectedItemsAmount = 0;
        break;
      case 'Group':
        maxItems = selectedGroup != null ? selectedGroup.flashcards.length : 0;
        if (selectedItemsAmount < maxItems) selectedItemsAmount = 0;
        break;
    }
  }
}
