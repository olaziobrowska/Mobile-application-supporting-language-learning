import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_app/models/userModel.dart';

final String pointsFirebaseColumn = "Points";
final String maxPointsFirebaseColumn = "MaxPoints";
final String dateFirebaseColumn = "Date";

class FlashcardTestModel {
  String id;
  int points;
  int maxPoints;
  DateTime date;

  FlashcardTestModel._({this.id, this.points, this.maxPoints, this.date});

  static FlashcardTestModel newFlashcardTest(
      {UserModel userModel, int maxPoints}) {
    if (userModel == null) return null;
    return FlashcardTestModel._(
        id: userModel.id,
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
        date: map[dateFirebaseColumn]);
  }

  static Map<String, dynamic> toMap(FlashcardTestModel testModel) {
    if (testModel == null) return null;
    Map<String, dynamic> output = Map();
    if (testModel.points != null)
      output[pointsFirebaseColumn] = testModel.points;
    if (testModel.maxPoints != null)
      output[maxPointsFirebaseColumn] = testModel.maxPoints;
    if (testModel.date != null) output[dateFirebaseColumn] = testModel.date;
    return output;
  }
}
