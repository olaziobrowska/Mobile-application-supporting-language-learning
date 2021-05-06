import 'package:language_app/models/flashcards/flashcardGroupModel.dart';
import 'package:language_app/utils/local_storage/storage.dart';

class FlashcardGroupViewModel {
  String id;
  String uid;
  String name;
  String language;

  FlashcardGroupViewModel._({this.id, this.name, this.uid, this.language});

  static FlashcardGroupViewModel createNew(String name) {
    return FlashcardGroupViewModel._(name: name,
        uid: AppStorage.loggedInUser.uid,
        language: AppStorage.loggedInUser.languageSelected);
  }

  static FlashcardGroupViewModel fromModel(FlashcardGroupModel groupModel) {
    return FlashcardGroupViewModel._(id: groupModel.flashcardGroupID,
        uid: groupModel.uid,
        language: groupModel.language,
        name: groupModel.name);
  }
}