import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_app/models/userModel.dart';

final String pointsFirebaseColumn = "Points";
final String nameFirebaseColumn = "Name";
final String dateFirebaseColumn = "Date";

class LessonModel {
  String id;
  String name;
  DateTime date;

  LessonModel._({this.id, this.name, this.date});

  static LessonModel newLesson({UserModel userModel, String name}) {
    if (userModel == null) return null;
    return LessonModel._(id: userModel.id, name: name, date: DateTime.now());
  }

  static LessonModel newFromFireStore(DocumentSnapshot document) {
    var map = document.data;
    return LessonModel._(
        id: document.documentID,
        name: map[nameFirebaseColumn],
        date: map[dateFirebaseColumn]);
  }

  static Map<String, dynamic> toMap(LessonModel lessonModel) {
    if (lessonModel == null) return null;
    Map<String, dynamic> output = Map();
    if (lessonModel.name != null) output[nameFirebaseColumn] = lessonModel.name;
    if (lessonModel.date != null) output[dateFirebaseColumn] = lessonModel.date;
    return output;
  }
}
