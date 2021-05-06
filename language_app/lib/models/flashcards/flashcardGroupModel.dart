import 'package:cloud_firestore/cloud_firestore.dart';
import '../../view_models/flashcards/flashcardGroupViewModel.dart';

final String nameFirebaseColumn = "Name";
final String uidFirebaseColumn = "Uid";
final String languageFirebaseColumn = "Language";

class FlashcardGroupModel {
  String flashcardGroupID;
  String uid;
  String language;
  String name;

  FlashcardGroupModel._({this.flashcardGroupID, this.uid, this.language, this.name});

  static FlashcardGroupModel New(
      String flashcardGroupID, String uid, String language, String name) {
    return FlashcardGroupModel._(
        flashcardGroupID: flashcardGroupID,
        uid: uid,
        language: language,
        name: name);
  }

  static FlashcardGroupModel fromViewModel(FlashcardGroupViewModel groupViewModel){
    return FlashcardGroupModel._(
      flashcardGroupID: groupViewModel.id,
      uid: groupViewModel.uid,
      name: groupViewModel.name,
      language: groupViewModel.language
    );
  }

  static FlashcardGroupModel newFromFireStore(DocumentSnapshot document) {
    var map = document.data;
    return FlashcardGroupModel._(
        flashcardGroupID: document.documentID,
        uid: map[uidFirebaseColumn],
        language: map[languageFirebaseColumn],
        name: map[nameFirebaseColumn]);
  }

  static Map<String, dynamic> toMap(FlashcardGroupModel flashcardGroupModel) {
    if (flashcardGroupModel == null) return null;
    Map<String, dynamic> output = Map();
    if (flashcardGroupModel.language != null)
      output[languageFirebaseColumn] = flashcardGroupModel.language;
    if (flashcardGroupModel.uid != null)
      output[uidFirebaseColumn] = flashcardGroupModel.uid;
    if (flashcardGroupModel.name != null)
      output[nameFirebaseColumn] = flashcardGroupModel.name;
    return output;
  }
}
