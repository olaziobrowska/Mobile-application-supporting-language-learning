import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_app/models/userModel.dart';

final String wordFirebaseColumn = "Word";
final String translatedWordFirebaseColumn = "TranslatedWord";
final String positiveAnswersFirebaseColumn = "PositiveAnswers";
final String negativeAnswersFirebaseColumn = "NegativeAnswers";
final String uidFirebaseColumn = "Uid";

class FlashcardModel {
  String id;
  String word;
  String translatedWord;
  int positiveAnswers;
  int negativeAnswers;
  String uid;

  FlashcardModel._(
      {this.id,
      this.word,
      this.translatedWord,
      this.positiveAnswers,
      this.negativeAnswers,
      this.uid});

  static FlashcardModel newFlashcard(
      {UserModel userModel, String word, String translatedWord}) {
    if (userModel == null) return null;
    return FlashcardModel._(
        uid: userModel.id,
        word: word,
        translatedWord: translatedWord,
        positiveAnswers: 0,
        negativeAnswers: 0);
  }

  static FlashcardModel newFromFireStore(DocumentSnapshot document) {
    var map = document.data;
    return FlashcardModel._(
        id: document.documentID,
        word: map[wordFirebaseColumn],
        translatedWord: map[translatedWordFirebaseColumn],
        positiveAnswers: map[positiveAnswersFirebaseColumn],
        negativeAnswers: map[negativeAnswersFirebaseColumn],
        uid: map[uidFirebaseColumn]);
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
    if (flashcardModel.uid != null)
      output[uidFirebaseColumn] = flashcardModel.uid;
    return output;
  }
}
