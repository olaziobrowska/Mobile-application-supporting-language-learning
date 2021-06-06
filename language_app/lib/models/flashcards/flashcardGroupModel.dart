import 'package:cloud_firestore/cloud_firestore.dart';
import '../../view_models/flashcards/flashcardGroupViewModel.dart';

final String nameFirebaseColumn = "Name";
final String uidFirebaseColumn = "Uid";
final String languageFirebaseColumn = "Language";
final String publicFirebaseColumn = "Public";

class FlashcardGroupModel {
  String flashcardGroupID;
  String uid;
  String language;
  String name;
  bool public;

  FlashcardGroupModel._({this.flashcardGroupID, this.uid, this.language, this.name, this.public});

  static FlashcardGroupModel New(
      String flashcardGroupID, String uid, String language, String name) {
    return FlashcardGroupModel._(
        flashcardGroupID: flashcardGroupID,
        uid: uid,
        language: language,
        name: name,
        public: false);
  }

  static FlashcardGroupModel fromViewModel(FlashcardGroupViewModel groupViewModel){
    return FlashcardGroupModel._(
      flashcardGroupID: groupViewModel.id,
      uid: groupViewModel.uid,
      name: groupViewModel.name,
      language: groupViewModel.language,
      public: groupViewModel.public
    );
  }

  static FlashcardGroupModel newFromFireStore(DocumentSnapshot document) {
    var map = document.data;
    return FlashcardGroupModel._(
        flashcardGroupID: document.documentID,
        uid: map[uidFirebaseColumn],
        language: map[languageFirebaseColumn],
        name: map[nameFirebaseColumn],
        public: map[publicFirebaseColumn]);
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
    output[publicFirebaseColumn] = flashcardGroupModel.public;
    return output;
  }
}
