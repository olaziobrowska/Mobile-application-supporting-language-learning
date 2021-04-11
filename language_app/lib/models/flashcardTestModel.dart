import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_app/models/userModel.dart';

final String pointsFirebaseColumn = "Points";
final String maxPointsFirebaseColumn = "MaxPoints";
final String dateFirebaseColumn = "Date";
final String uidFirebaseColumn = "Uid";

class FlashcardTestModel {
  String id;
  int points;
  int maxPoints;
  DateTime date;
  String uid;

  FlashcardTestModel._(
      {this.id, this.points, this.maxPoints, this.date, this.uid});

  static FlashcardTestModel newFlashcardTest(
      {UserModel userModel, int maxPoints}) {
    if (userModel == null) return null;
    return FlashcardTestModel._(
        uid: userModel.id,
        points: 0,
        maxPoints: maxPoints,
        date: DateTime.now());
  }

  static FlashcardTestModel newFromFireStore(DocumentSnapshot document) {
    var map = document.data;
    return FlashcardTestModel._(
        id: document.documentID,
        points: map[pointsFirebaseColumn],
        maxPoints: map[maxPointsFirebaseColumn],
        date: map[dateFirebaseColumn],
        uid: map[uidFirebaseColumn]);
  }

  static Map<String, dynamic> toMap(FlashcardTestModel flashcardTestModel) {
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
