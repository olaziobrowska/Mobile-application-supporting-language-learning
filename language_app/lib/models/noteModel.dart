import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_app/models/userModel.dart';

final String lessonIdFirebaseColumn = "LessonId";
final String titleFirebaseColumn = "Title";
final String dateFirebaseColumn = "Date";
final String contentFirebaseColumn = "Content";
final String attachmentFirebaseColumn = "Attachment";
final String uidNoteFirebaseColumn = "Uid";

class NoteModel {
  String id;
  String lessonId;
  String title = "";
  Timestamp date;
  List<String> content = [""];
  List<String> attachment = [""];
  String uid;

  NoteModel._(
      {this.id,
      this.lessonId,
      this.title,
      this.date,
      this.content,
      this.attachment,
      this.uid});

  static NoteModel empty() {
    return NoteModel._(
        uid: "",
        lessonId: "",
        title: "",
        content: [""],
        attachment: [""],
        date: Timestamp.now());
  }

  static NoteModel newNote(
      {UserModel userModel,
      String lessonId,
      String title,
      List<String> content,
      List<String> attachment}) {
    if (userModel == null) return null;
    return NoteModel._(
        uid: userModel.id,
        lessonId: lessonId,
        title: title,
        content: content,
        date: Timestamp.now(),
        attachment: attachment);
  }

  static NoteModel newFromFireStore(DocumentSnapshot document) {
    var map = document.data;
    return NoteModel._(
        id: document.documentID,
        lessonId: map[lessonIdFirebaseColumn],
        title: map[titleFirebaseColumn],
        content: map[contentFirebaseColumn].cast<String>(),
        date: map[dateFirebaseColumn],
        attachment: map[attachmentFirebaseColumn].cast<String>(),
        uid: map[uidNoteFirebaseColumn]);
  }

  static Map<String, dynamic> toMap(NoteModel noteModel) {
    if (noteModel == null) return null;
    Map<String, dynamic> output = Map();
    if (noteModel.lessonId != null)
      output[lessonIdFirebaseColumn] = noteModel.lessonId;
    if (noteModel.title != null) output[titleFirebaseColumn] = noteModel.title;
    if (noteModel.content != null)
      output[contentFirebaseColumn] = noteModel.content;
    if (noteModel.date != null) output[dateFirebaseColumn] = noteModel.date;
    if (noteModel.attachment != null)
      output[attachmentFirebaseColumn] = noteModel.attachment;
    if (noteModel.uid != null) output[uidNoteFirebaseColumn] = noteModel.uid;
    return output;
  }
}
