import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/services/flashcardService.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/view_models/errorViewModel.dart';
import 'package:language_app/view_models/flashcards/flashcardGroupViewModel.dart';
import 'package:language_app/view_models/flashcards/flashcardViewModel.dart';

class FlashcardsViewsCode extends ChangeNotifier {
  FlashcardsViewsCode._();
  static final FlashcardsViewsCode instance = FlashcardsViewsCode._();
  final FlashcardService _service = FlashcardService.instance;
  final NavigationService _navigationService = locator<NavigationService>();
  
  bool errorOccurred = false;
  String errorMessage = "";
  
  List<FlashcardGroupViewModel> usersGroups = [];
  List<FlashcardViewModel> displayedFlashcards = [];
  FlashcardGroupViewModel selectedGroup;

  String newFlashcardGroupInput = "";
  String newFlashcardWordInput = "";
  String newFlashcardTranslatedInput = "";
  
  
  Future<void> fetchUserFlashcardGroups() async {
    try{
      usersGroups = await _service.getUsersFlashcardGroups();
    } on ErrorViewModel catch(e){
      errorOccurred = true;
      errorMessage = e.message;
    } catch(e){
      errorOccurred = true;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> fetchGroupFlashcards() async {
    try {
      displayedFlashcards = await _service.getFlashcardsInGroup(selectedGroup.id);
    }on ErrorViewModel catch(e){
      errorOccurred = true;
      errorMessage = e.message;
    } catch(e){
      errorOccurred = true;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  navigateToFlashcards(FlashcardGroupViewModel groupViewModel){
    selectedGroup = groupViewModel;
    _navigationService.navigateTo("flashcardsView", []);
  }

  addNewFlashcardGroup() async {
    try{
      await _service.addFlashcardGroup(newFlashcardGroupInput);
      await fetchUserFlashcardGroups();
      newFlashcardGroupInput = "";
    } on ErrorViewModel catch(e){
      errorOccurred = true;
      errorMessage = e.message;
    } catch(e){
      errorOccurred = true;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  addNewFlashcard() async {
    try {
      await _service.addFlashcardByGroupID(newFlashcardWordInput, newFlashcardTranslatedInput, selectedGroup.id);
      await fetchGroupFlashcards();
      newFlashcardWordInput = "";
      newFlashcardTranslatedInput = "";
    }on ErrorViewModel catch(e){
      errorOccurred = true;
      errorMessage = e.message;
    } catch(e){
      errorOccurred = true;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
  
  Widget logErrorSnackBar() {
    if(!errorOccurred) return Container();
    errorOccurred = false;
    return SnackBar(content: Text(errorMessage));
  }

}