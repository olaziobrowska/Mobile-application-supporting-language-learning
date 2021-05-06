import 'package:language_app/models/flashcards/flashcardGroupModel.dart';
import '../view_models/flashcards/flashcardGroupViewModel.dart';
import '../models/flashcards/flashcardModel.dart';
import 'package:language_app/repositories/flashcardRepository.dart';
import '../view_models/flashcards/flashcardViewModel.dart';

class FlashcardService {
  FlashcardService._();

  static final FlashcardService instance = FlashcardService._();

  final FlashcardRepository _repository = FlashcardRepository.instance;

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
      String word, String translation) async {
    try {
      var flashcardGroups = await getUsersFlashcardGroups();
      var groupRef;
      var defaultGroup = flashcardGroups.firstWhere(
          (element) => element.name == "Translations",
          orElse: () => null);
      if (defaultGroup == null) {
        groupRef = addFlashcardGroup("Translations");
      } else {
        groupRef = defaultGroup.id;
      }
      FlashcardViewModel flashcardViewModel =
          FlashcardViewModel.newFlashcard(word, translation, groupRef);
      await _repository
          .addNewFlashCard(FlashcardModel.newFromViewModel(flashcardViewModel));
    } catch (e) {
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
        output.add(FlashcardGroupViewModel.fromModel(model));
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
    try{
      var userGroups = await getUsersFlashcardGroups();
      var models = [];
      for(var group in userGroups){
        models.add(await getFlashcardsInGroup(group.id));
      }
      return models;
    } catch(e){
      throw e;
    }
  }
}
