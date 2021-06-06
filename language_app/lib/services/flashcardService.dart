import 'package:language_app/models/flashcards/flashcardGroupModel.dart';
import 'package:language_app/repositories/userRepository.dart';
import 'package:language_app/utils/local_storage/storage.dart';
import 'package:language_app/view_models/errorViewModel.dart';
import '../view_models/flashcards/flashcardGroupViewModel.dart';
import '../models/flashcards/flashcardModel.dart';
import 'package:language_app/repositories/flashcardRepository.dart';
import '../view_models/flashcards/flashcardViewModel.dart';

class FlashcardService {
  FlashcardService._();

  static final FlashcardService instance = FlashcardService._();

  final FlashcardRepository _repository = FlashcardRepository.instance;
  final UserRepository _userRepository = UserRepository.instance;

  Future<void> addFlashcardByGroupID(
      String word, String translation, String selectedGroupID) async {
    try {
      FlashcardViewModel flashcardViewModel =
          FlashcardViewModel.newFlashcard(word, translation, selectedGroupID);
      await _repository
          .addNewFlashCard(FlashcardModel.newFromViewModel(flashcardViewModel));
    } catch (e) {
      throw e;
    }
  }

  Future<void> addFlashcardByTranslationScreen(
      String word, String translation, String selLanguage) async {
    var temp = AppStorage.loggedInUser.languageSelected;
    try {
      AppStorage.loggedInUser.languageSelected = selLanguage;
      var flashcardGroups = await getUsersFlashcardGroups();
      var groupRef;
      var defaultGroup = flashcardGroups.firstWhere(
          (element) =>
              element.name ==
                  AppStorage.loggedInUser.languageSelected + " translations" &&
              element.language == AppStorage.loggedInUser.languageSelected,
          orElse: () => null);
      if (defaultGroup == null) {
        groupRef = await addFlashcardGroup(
            AppStorage.loggedInUser.languageSelected + " translations");
      } else {
        groupRef = defaultGroup.id;
      }
      FlashcardViewModel flashcardViewModel =
          FlashcardViewModel.newFlashcard(word, translation, groupRef);
      await _repository
          .addNewFlashCard(FlashcardModel.newFromViewModel(flashcardViewModel));
      AppStorage.loggedInUser.languageSelected = temp;
    } catch (e) {
      AppStorage.loggedInUser.languageSelected = temp;
      throw e;
    }
  }

  Future<String> addFlashcardGroup(String name) async {
    try {
      FlashcardGroupViewModel groupViewModel =
          FlashcardGroupViewModel.createNew(name);
      return await _repository.addNewFlashcardGroup(
          FlashcardGroupModel.fromViewModel(groupViewModel));
    } catch (e) {
      throw e;
    }
  }

  Future<List<FlashcardGroupViewModel>> getUsersFlashcardGroups() async {
    try {
      var groupModels = await _repository.getUsersFlashcardGroups();
      List<FlashcardGroupViewModel> output = [];
      for (var model in groupModels) {
        output.add(FlashcardGroupViewModel.fromModel(
            model,
            await getFlashcardsInGroup(model.flashcardGroupID),
            AppStorage.loggedInUser.names()));
      }
      return output;
    } catch (e) {
      throw e;
    }
  }

  Future<List<FlashcardGroupViewModel>> getPublicFlashcardGroups() async {
    try {
      var groupModels = await _repository.getPublicFlashcardGroups();
      List<FlashcardGroupViewModel> output = [];
      for (var model in groupModels) {
        var author = await _userRepository.getUserByUID(model.uid);
        output.add(FlashcardGroupViewModel.fromModel(
            model,
            await getFlashcardsInGroup(model.flashcardGroupID),
            author.names()));
      }
      return output;
    } catch (e) {
      throw e;
    }
  }

  Future<List<FlashcardViewModel>> getFlashcardsInGroup(String groupID) async {
    try {
      var models = await _repository.getGroupsFlashCards(groupID);
      List<FlashcardViewModel> output = [];
      for (var model in models) {
        output.add(FlashcardViewModel.newFromModel(model));
      }
      return output;
    } catch (e) {
      throw e;
    }
  }

  Future<void> changeFlashcardGroupName(
      FlashcardGroupViewModel groupViewModel) async {
    try {
      await _repository.editFlashcardGroup(
          FlashcardGroupModel.fromViewModel(groupViewModel));
    } catch (e) {
      throw e;
    }
  }

  Future<void> changeFlashcard(FlashcardViewModel flashcardViewModel) async {
    try {
      await _repository
          .editFlashCard(FlashcardModel.newFromViewModel(flashcardViewModel));
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteFlashcardGroup(
      FlashcardGroupViewModel flashcardGroupViewModel) async {
    try {
      await _repository.deleteFlashcardGroup(
          FlashcardGroupModel.fromViewModel(flashcardGroupViewModel));
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteFlashcard(FlashcardViewModel flashcardViewModel) async {
    try {
      await _repository
          .deleteFlashCard(FlashcardModel.newFromViewModel(flashcardViewModel));
    } catch (e) {
      throw e;
    }
  }

  Future<List<FlashcardViewModel>> getAllUsersFlashcardsAcrossGroups() async {
    try {
      var userGroups = await getUsersFlashcardGroups();
      var models = [];
      for (var group in userGroups) {
        models.add(await getFlashcardsInGroup(group.id));
      }
      return models;
    } catch (e) {
      throw e;
    }
  }

  Future<List<FlashcardViewModel>> getFlashcardsInIDs(List<String> ids) async {
    try {
      var flashcards = await _repository.getFlashcardsInIDs(ids);
      List<FlashcardViewModel> output = [];
      for (var flashcard in flashcards) {
        output.add(FlashcardViewModel.newFromModel(flashcard));
      }
      return output;
    } catch (e) {
      throw e;
    }
  }

  Future<void> downloadPublicFlashcardGroup(
      FlashcardGroupViewModel groupViewModel) async {
    try {
      if (!groupViewModel.public)
        throw ErrorViewModel.newFromMessage(
            "Not allowed to download this group!");
      var author = await _userRepository.getUserByUID(groupViewModel.uid);
      var userFlashcards = await getUsersFlashcardGroups();
      var name = "";
      int i = 0;
      while(true)
        {
          name = groupViewModel.name + " by " + author.name + " " + author.surname;
          name = i == 0 ? name : name + " ($i)";
          if(userFlashcards.firstWhere((element) => element.name == name, orElse: () => null) == null)
          {
            break;
          }
          i++;
        }
      var copiedGroup = await addFlashcardGroup(
          name);
      for (var flashcard in groupViewModel.flashcards) {
        await addFlashcardByGroupID(
            flashcard.word, flashcard.translatedWord, copiedGroup);
      }
    } catch (e) {
      throw e;
    }
  }
}
