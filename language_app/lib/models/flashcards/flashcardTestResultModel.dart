import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_app/utils/local_storage/storage.dart';
import 'package:language_app/view_models/flashcards/flashcardTestResultViewModel.dart';

final String pointsFirebaseColumn = "Points";
final String maxPointsFirebaseColumn = "MaxPoints";
final String dateFirebaseColumn = "Date";
final String uidFirebaseColumn = "Uid";

class FlashcardTestResultModel {
  String id;
  int points;
  int maxPoints;
  Timestamp date;
  String uid;

  FlashcardTestResultModel._(
      {this.id, this.points, this.maxPoints, this.date, this.uid});

  static FlashcardTestResultModel newFromViewModel(
      FlashcardTestResultViewModel viewModel) {
    return FlashcardTestResultModel._(
        uid: AppStorage.loggedInUser.uid,
        points: viewModel.points,
        maxPoints: viewModel.maxPoints,
        date: viewModel.date,
        id: viewModel.id);
  }

  static FlashcardTestResultModel newFromFireStore(DocumentSnapshot document) {
    var map = document.data;
    return FlashcardTestResultModel._(
        id: document.documentID,
        points: map[pointsFirebaseColumn],
        maxPoints: map[maxPointsFirebaseColumn],
        date: map[dateFirebaseColumn],
        uid: map[uidFirebaseColumn]);
  }

  static Map<String, dynamic> toMap(FlashcardTestResultModel flashcardTestModel) {
    if (flashcardTestModel == null) return null;
    Map<String, dynamic> output = Map();
    if (flashcardTestModel.points != null)
      output[pointsFirebaseColumn] = flashcardTestModel.points;
    if (flashcardTestModel.maxPoints != null)
      output[maxPointsFirebaseColumn] = flashcardTestModel.maxPoints;
    if (flashcardTestModel.date != null) output[dateFirebaseColumn] = flashcardTestModel.date;
    if (flashcardTestModel.uid != null) output[uidFirebaseColumn] = flashcardTestModel.uid;
    return output;
  }
}
