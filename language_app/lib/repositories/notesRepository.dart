import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_app/models/noteModel.dart';
import 'package:language_app/models/lessonModel.dart';
import 'package:language_app/utils/local_storage/storage.dart';
import 'package:language_app/view_models/errorViewModel.dart';

class NotesRepository {
  String _collectionName = "Notes";

  NotesRepository._();

  static final NotesRepository instance = NotesRepository._();
  Firestore fireStore = Firestore.instance;

  Future<String> addNote(LessonModel lessonModel, NoteModel noteModel) async {
    var user = AppStorage.loggedInUser;
    noteModel.uid = user.uid;
    noteModel.lessonId = lessonModel.id;
    if (lessonModel == null || noteModel == null) return null;
    try {
      CollectionReference collection = fireStore.collection(_collectionName);
      var output = await collection.add(NoteModel.toMap(noteModel));
      noteModel.id = output.documentID;
      return "Success";
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> editNote(NoteModel noteModel) async {
    if (noteModel == null || noteModel.id == null)
      throw ErrorViewModel.newFromMessage("No note specified!");
    try {
      await fireStore
          .collection(_collectionName)
          .document(noteModel.id)
          .setData(NoteModel.toMap(noteModel));
    } catch (e) {
      throw e;
    }
  }

  Future<NoteModel> getNotesByLessonId(String uid, String lessonModelId) async {
    if (uid == null || lessonModelId == null) return null;
    try {
      var query = await fireStore
          .collection(_collectionName)
          .where(uidNoteFirebaseColumn, isEqualTo: AppStorage.loggedInUser.uid)
          .where(lessonIdFirebaseColumn, isEqualTo: lessonModelId)
          .getDocuments();
      var output;
      if (query.documents.length == 0)
        output = NoteModel.empty();
      else
        output = NoteModel.newFromFireStore(query.documents[0]);
      return output;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
