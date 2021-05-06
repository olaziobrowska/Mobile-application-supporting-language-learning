import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_app/models/userModel.dart';

final String pointsFirebaseColumn = "Points";
final String nameFirebaseColumn = "Name";
final String dateFirebaseColumn = "Date";
final String uidFirebaseColumn = "Uid";
final String languageFirebaseColumn = "Language";

class LessonModel {
  String id;
  String name;
  DateTime date;
  String uid;
  String language;

  LessonModel._({this.id, this.name, this.date, this.uid, this.language});

  static LessonModel newLesson({UserModel userModel, String name}) {
    if (userModel == null) return null;
    return LessonModel._(
        uid: userModel.id,
        name: name,
        date: DateTime.now(),
        language: userModel.languageSelected);
  }

  static LessonModel newFromFireStore(DocumentSnapshot document) {
    var map = document.data;
    return LessonModel._(
        id: document.documentID,
        name: map[nameFirebaseColumn],
        date: map[dateFirebaseColumn],
        uid: map[uidFirebaseColumn],
        language: map[languageFirebaseColumn]);
  }

  static Map<String, dynamic> toMap(LessonModel lessonModel) {
    if (lessonModel == null) return null;
    Map<String, dynamic> output = Map();
    if (lessonModel.name != null) output[nameFirebaseColumn] = lessonModel.name;
    if (lessonModel.date != null) output[dateFirebaseColumn] = lessonModel.date;
    if (lessonModel.uid != null) output[uidFirebaseColumn] = lessonModel.uid;
    if (lessonModel.language != null)
      output[languageFirebaseColumn] = lessonModel.language;
    return output;
  }
}
