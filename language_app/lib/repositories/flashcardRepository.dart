import 'package:language_app/models/flashcards/flashcardGroupModel.dart';
import '../models/flashcards/flashcardModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_app/utils/local_storage/storage.dart';
import 'package:language_app/view_models/errorViewModel.dart';

class FlashcardRepository {
  FlashcardRepository._();

  static final FlashcardRepository instance = FlashcardRepository._();

  final String _flashcardCollectionName = "Flashcards";
  final String _flashcardGroupCollectionName = "FlashcardGroups";
  Firestore _fireStore = Firestore.instance;

  Future<List<FlashcardModel>> getGroupsFlashCards(String groupID) async {
    try {
      var output = await _fireStore
          .collection(_flashcardCollectionName)
          .where(groupIDFirebaseColumn, isEqualTo: groupID)
          .getDocuments();
      List<FlashcardModel> flashcards = [];
      for (var doc in output.documents) {
        flashcards.add(FlashcardModel.newFromFireStore(doc));
      }
      return flashcards;
    } catch (e) {
      throw e;
    }
  }

  Future<void> addNewFlashCard(FlashcardModel flashcardModel) async {
    if (flashcardModel == null)
      throw ErrorViewModel.newFromMessage("No flashcard specified!");
    try {
      await _fireStore
          .collection(_flashcardCollectionName)
          .add(FlashcardModel.toMap(flashcardModel));
    } catch (e) {
      throw e;
    }
  }
  
  Future<void> editFlashCard(FlashcardModel flashcardModel) async {
    if (flashcardModel == null || flashcardModel.id == null)
      throw ErrorViewModel.newFromMessage("No flashcard specified!");
    try {
      await _fireStore
          .collection(_flashcardCollectionName)
          .document(flashcardModel.id)
          .setData(FlashcardModel.toMap(flashcardModel));
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteFlashCard(FlashcardModel flashcardModel) async {
    if (flashcardModel == null || flashcardModel.id == null)
      throw ErrorViewModel.newFromMessage("No flashcard specified!");
    try {
      await _fireStore
          .collection(_flashcardCollectionName)
          .document(flashcardModel.id)
          .delete();
    } catch (e) {
      throw e;
    }
  }

  Future<List<FlashcardGroupModel>> getUsersFlashcardGroups() async {
    if (AppStorage.loggedInUser == null) return null;
    try {
      var output = await _fireStore
          .collection(_flashcardGroupCollectionName)
          .where(uidFirebaseColumn, isEqualTo: AppStorage.loggedInUser.uid)
          .where(languageFirebaseColumn, isEqualTo: AppStorage.loggedInUser.languageSelected)
          .getDocuments();
      List<FlashcardGroupModel> flashcardGroups = [];
      for (var doc in output.documents) {
        flashcardGroups.add(FlashcardGroupModel.newFromFireStore(doc));
      }
      return flashcardGroups;
    } catch (e) {
      throw e;
    }
  }

  Future<List<FlashcardGroupModel>> getPublicFlashcardGroups() async {
    if (AppStorage.loggedInUser == null) return null;
    try {
      var output = await _fireStore
          .collection(_flashcardGroupCollectionName)
          .where(languageFirebaseColumn, isEqualTo: AppStorage.loggedInUser.languageSelected)
          .where(publicFirebaseColumn, isEqualTo: true)
          .getDocuments();
      List<FlashcardGroupModel> flashcardGroups = [];
      for (var doc in output.documents) {
        flashcardGroups.add(FlashcardGroupModel.newFromFireStore(doc));
      }
      return flashcardGroups;
    } catch (e) {
      throw e;
    }
  }

  Future<String> addNewFlashcardGroup(FlashcardGroupModel flashcardGroupModel) async {
    if (flashcardGroupModel == null)
      throw ErrorViewModel.newFromMessage("No flashcard group specified!");
    try {
      var result = await _fireStore
          .collection(_flashcardGroupCollectionName)
          .add(FlashcardGroupModel.toMap(flashcardGroupModel));
      return result.documentID;
    } catch (e) {
      throw e;
    }
  }

  Future<void> editFlashcardGroup(FlashcardGroupModel flashcardGroupModel) async {
    if (flashcardGroupModel == null || flashcardGroupModel.flashcardGroupID == null)
      throw ErrorViewModel.newFromMessage("No flashcard group specified!");
    try {
      await _fireStore
          .collection(_flashcardGroupCollectionName)
          .document(flashcardGroupModel.flashcardGroupID)
          .setData(FlashcardGroupModel.toMap(flashcardGroupModel));
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteFlashcardGroup(FlashcardGroupModel flashcardGroupModel) async {
    if (flashcardGroupModel == null || flashcardGroupModel.flashcardGroupID == null)
      throw ErrorViewModel.newFromMessage("No flashcard specified!");
    try {
      var flashcards = await _fireStore
          .collection(_flashcardCollectionName)
          .where(groupIDFirebaseColumn, isEqualTo: flashcardGroupModel.flashcardGroupID)
          .getDocuments();
      for(var doc in flashcards.documents){
        deleteFlashCard(FlashcardModel.newFromFireStore(doc));
      }
      await _fireStore
          .collection(_flashcardGroupCollectionName)
          .document(flashcardGroupModel.flashcardGroupID)
          .delete();
    } catch (e) {
      throw e;
    }
  }

  Future<List<FlashcardModel>> getFlashcardsInIDs(List<String> ids) async {
    if (ids == null || ids.length == 0)
      throw ErrorViewModel.newFromMessage("No flashcards specified!");
    try {
      List<FlashcardModel> output = [];
      for(var i = 0; i<ids.length;i++){
        var doc = await _fireStore.collection(_flashcardCollectionName).document(ids[i]).get();
        output.add(FlashcardModel.newFromFireStore(doc));
      }
      return output;
    } catch (e) {
      throw e;
    }
  }
}
