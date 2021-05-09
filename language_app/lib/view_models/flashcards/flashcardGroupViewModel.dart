import 'package:language_app/models/flashcards/flashcardGroupModel.dart';
import 'package:language_app/utils/local_storage/storage.dart';
import 'package:language_app/view_models/flashcards/flashcardViewModel.dart';

class FlashcardGroupViewModel {
  String id;
  String uid;
  String name;
  String language;
  List<FlashcardViewModel> flashcards;

  FlashcardGroupViewModel._({this.id, this.name, this.uid, this.language, this.flashcards});

  static FlashcardGroupViewModel createNew(String name) {
    return FlashcardGroupViewModel._(name: name,
        uid: AppStorage.loggedInUser.uid,
        language: AppStorage.loggedInUser.languageSelected,
        flashcards: []);
  }

  static FlashcardGroupViewModel fromModel(FlashcardGroupModel groupModel, List<FlashcardViewModel> flashcardModels) {
    return FlashcardGroupViewModel._(id: groupModel.flashcardGroupID,
        uid: groupModel.uid,
        language: groupModel.language,
        name: groupModel.name,
        flashcards: flashcardModels);
  }
}