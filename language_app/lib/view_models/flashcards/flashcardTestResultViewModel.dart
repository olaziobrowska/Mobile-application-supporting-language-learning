import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_app/models/flashcards/flashcardTestResultModel.dart';

import '../userViewModel.dart';

class FlashcardTestResultViewModel {
  String id;
  int points;
  int maxPoints;
  Timestamp date;
  String uid;

  FlashcardTestResultViewModel._(
      {this.id, this.points, this.maxPoints, this.date, this.uid});

  static FlashcardTestResultViewModel newFlashcardTest(
      UserViewModel userViewModel,int score, int maxPoints) {
    if (userViewModel == null) return null;
    return FlashcardTestResultViewModel._(
        uid: userViewModel.uid,
        points: score,
        maxPoints: maxPoints,
        date: Timestamp.now());
  }

  static FlashcardTestResultViewModel newFromModel(FlashcardTestResultModel model){
    return FlashcardTestResultViewModel._(
      uid: model.uid,
      points: model.points,
      maxPoints: model.maxPoints,
      date: model.date,
      id: model.id
    );
  }
}
