import 'package:cloud_firestore/cloud_firestore.dart';
import '../../view_models/flashcards/flashcardViewModel.dart';

final String wordFirebaseColumn = "Word";
final String translatedWordFirebaseColumn = "TranslatedWord";
final String positiveAnswersFirebaseColumn = "PositiveAnswers";
final String negativeAnswersFirebaseColumn = "NegativeAnswers";
final String groupIDFirebaseColumn = "GroupID";

class FlashcardModel {
  String id;
  String word;
  String translatedWord;
  String groupID;
  int positiveAnswers;
  int negativeAnswers;

  FlashcardModel._(
      {this.id,
      this.word,
      this.translatedWord,
      this.positiveAnswers,
      this.negativeAnswers,
      this.groupID});

  static FlashcardModel newFromViewModel(
      FlashcardViewModel flashcardViewModel) {
    if (flashcardViewModel == null) return null;
    return FlashcardModel._(
        id: flashcardViewModel.id,
        word: flashcardViewModel.word,
        translatedWord: flashcardViewModel.translatedWord,
        positiveAnswers: flashcardViewModel.positiveAnswers,
        negativeAnswers: flashcardViewModel.negativeAnswers,
        groupID: flashcardViewModel.groupID);
  }

  static FlashcardModel newFromFireStore(DocumentSnapshot document) {
    var map = document.data;
    return FlashcardModel._(
        id: document.documentID,
        word: map[wordFirebaseColumn],
        translatedWord: map[translatedWordFirebaseColumn],
        positiveAnswers: map[positiveAnswersFirebaseColumn],
        negativeAnswers: map[negativeAnswersFirebaseColumn],
        groupID: map[groupIDFirebaseColumn]);
  }

  static Map<String, dynamic> toMap(FlashcardModel flashcardModel) {
    if (flashcardModel == null) return null;
    Map<String, dynamic> output = Map();
    if (flashcardModel.word != null)
      output[wordFirebaseColumn] = flashcardModel.word;
    if (flashcardModel.translatedWord != null)
      output[translatedWordFirebaseColumn] = flashcardModel.translatedWord;
    if (flashcardModel.positiveAnswers != null)
      output[positiveAnswersFirebaseColumn] = flashcardModel.positiveAnswers;
    if (flashcardModel.negativeAnswers != null)
      output[negativeAnswersFirebaseColumn] = flashcardModel.negativeAnswers;
    if(flashcardModel.groupID != null){
      output[groupIDFirebaseColumn] = flashcardModel.groupID;
    }
    return output;
  }
}
