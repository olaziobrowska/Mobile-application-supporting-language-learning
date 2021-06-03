import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/services/flashcardService.dart';
import 'package:language_app/services/userService.dart';
import 'package:language_app/utils/local_storage/storage.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/view_models/errorViewModel.dart';
import 'package:language_app/view_models/flashcards/flashcardGroupViewModel.dart';
import 'package:language_app/view_models/flashcards/flashcardViewModel.dart';

import 'flashcardsViewsStyle.dart';

class FlashcardsViewsCode extends ChangeNotifier {
  FlashcardsViewsCode._();

  static final FlashcardsViewsCode instance = FlashcardsViewsCode._();
  final FlashcardService _service = FlashcardService.instance;
  final NavigationService _navigationService = locator<NavigationService>();

  bool errorOccurred = false;
  String errorMessage = "";

  List<FlashcardGroupViewModel> _usersGroups = [];
  List<FlashcardGroupViewModel> _publicGroups = [];
  FlashcardGroupViewModel selectedGroup;

  String newFlashcardGroupInput = "";
  String newFlashcardWordInput = "";
  String newFlashcardTranslatedInput = "";

  List<FlashcardGroupViewModel> getDisplayedList(bool showPublic) {
    return showPublic ? _publicGroups : _usersGroups;
  }

  List<FlashcardGroupViewModel> getUserList() {
    return _usersGroups;
  }

  Future<void> fetchUserFlashcardGroups() async {
    try {
      _usersGroups = await _service.getUsersFlashcardGroups();
    } on ErrorViewModel catch (e) {
      errorOccurred = true;
      errorMessage = e.message;
    } catch (e) {
      errorOccurred = true;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> fetchPublicFlashcardGroups() async {
    try {
      _publicGroups = await _service.getPublicFlashcardGroups();
    } on ErrorViewModel catch (e) {
      errorOccurred = true;
      errorMessage = e.message;
    } catch (e) {
      errorOccurred = true;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> fetchGroupFlashcards() async {
    try {
      selectedGroup.flashcards =
      await _service.getFlashcardsInGroup(selectedGroup.id);
    } on ErrorViewModel catch (e) {
      errorOccurred = true;
      errorMessage = e.message;
    } catch (e) {
      errorOccurred = true;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  navigateToFlashcards(FlashcardGroupViewModel groupViewModel) {
    selectedGroup = groupViewModel;
    _navigationService.navigateTo("flashcardsView", []);
  }

  addNewFlashcardGroup() async {
    try {
      await _service.addFlashcardGroup(newFlashcardGroupInput);
      await fetchUserFlashcardGroups();
      newFlashcardGroupInput = "";
    } on ErrorViewModel catch (e) {
      errorOccurred = true;
      errorMessage = e.message;
    } catch (e) {
      errorOccurred = true;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  addNewFlashcard() async {
    try {
      await _service.addFlashcardByGroupID(
          newFlashcardWordInput, newFlashcardTranslatedInput, selectedGroup.id);
      await fetchGroupFlashcards();
      newFlashcardWordInput = "";
      newFlashcardTranslatedInput = "";
    } on ErrorViewModel catch (e) {
      errorOccurred = true;
      errorMessage = e.message;
    } catch (e) {
      errorOccurred = true;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  changeGroupPublicity(FlashcardGroupViewModel groupViewModel) async {
    try {
      if (groupViewModel.uid !=
          AppStorage.loggedInUser.uid) throw ErrorViewModel.newFromMessage(
          "You are not allowed to alter this group!");
      groupViewModel.public = !groupViewModel.public;
      _service.changeFlashcardGroupName(groupViewModel);
    }on ErrorViewModel catch (e) {
      errorOccurred = true;
      errorMessage = e.message;
    } catch (e) {
      errorOccurred = true;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  downloadPublicGroup(FlashcardGroupViewModel groupViewModel) async {
    try {
      if (!groupViewModel.public) throw ErrorViewModel.newFromMessage(
          "You are not allowed to alter this group!");
      await _service.downloadPublicFlashcardGroup(groupViewModel);
    }on ErrorViewModel catch (e) {
      errorOccurred = true;
      errorMessage = e.message;
    } catch (e) {
      errorOccurred = true;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  bool isGroupCreator(FlashcardGroupViewModel group)
  {
    return group.uid == AppStorage.loggedInUser.uid;
  }

  Future<void> moveFlashcardToAnotherGroup(FlashcardViewModel flashcardViewModel, String newGroupID) async
  {
    flashcardViewModel.groupID = newGroupID;
    await _service.changeFlashcard(flashcardViewModel);
    await fetchGroupFlashcards();
    notifyListeners();
    await fetchPublicFlashcardGroups();
    await fetchUserFlashcardGroups();
    notifyListeners();
  }

  Widget generateGroupsOptions(FlashcardViewModel flashcardViewModel)
  {
    return PopupMenuButton<String>(
      onSelected: (value) {
        moveFlashcardToAnotherGroup(flashcardViewModel, value);
      },
      icon: kMoveFlashcardIcon,
      itemBuilder: (BuildContext context) {
        return getUserList().map((e) {
          return PopupMenuItem<String>(
            value: e.id, child: Text(e.name),
          );
        }).toList();
      },
    );
  }

  Widget logErrorSnackBar() {
    if (!errorOccurred) return Container();
    errorOccurred = false;
    return SnackBar(content: Text(errorMessage));
  }


}