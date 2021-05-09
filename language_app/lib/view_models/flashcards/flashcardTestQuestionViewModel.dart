import 'package:language_app/view_models/flashcards/flashcardViewModel.dart';

class FlashcardTestQuestionViewModel {
  String flashcardID;
  String wordToTranslate;
  String answer;
  List<String> answers;
  bool correctAnswer;

  FlashcardTestQuestionViewModel._(
      {this.wordToTranslate,
      this.answer,
      this.answers,
      this.flashcardID,
      this.correctAnswer});

  static FlashcardTestQuestionViewModel newForFlashcard(
      FlashcardViewModel flashcardViewModel, List<String> answers) {
    return FlashcardTestQuestionViewModel._(
        wordToTranslate: flashcardViewModel.word,
        answer: flashcardViewModel.translatedWord,
        answers: answers,
        flashcardID: flashcardViewModel.id,
        correctAnswer: false);
  }
}
