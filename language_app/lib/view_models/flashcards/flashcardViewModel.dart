import '../../models/flashcards/flashcardModel.dart';

class FlashcardViewModel {
  String id;
  String word;
  String translatedWord;
  String groupID;
  int positiveAnswers;
  int negativeAnswers;

  FlashcardViewModel._(
      {this.id,
        this.word,
        this.translatedWord,
        this.positiveAnswers,
        this.negativeAnswers,
        this.groupID});

  static FlashcardViewModel newFlashcard(String word, String translatedWord, String groupID) {
    return FlashcardViewModel._(
        word: word,
        translatedWord: translatedWord,
        positiveAnswers: 0,
        negativeAnswers: 0,
        groupID: groupID);
  }

  static FlashcardViewModel newFromModel(FlashcardModel model) {
    return FlashcardViewModel._(
        id: model.id,
        word: model.word,
        translatedWord: model.translatedWord,
        positiveAnswers: model.positiveAnswers,
        negativeAnswers: model.negativeAnswers,
        groupID: model.groupID);
  }
}
