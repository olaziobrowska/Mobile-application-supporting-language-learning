import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_app/models/noteModel.dart';
import 'package:language_app/models/lessonModel.dart';
import 'package:language_app/repositories/storageManagementTools.dart';
import 'package:language_app/utils/local_storage/storage.dart';
import 'package:language_app/view_models/errorViewModel.dart';
import 'dart:io';

class NotesRepository {
  String _collectionName = "Notes";

  NotesRepository._();

  static final NotesRepository instance = NotesRepository._();
  Firestore fireStore = Firestore.instance;
  StorageManagementTools storageManagementTools = new StorageManagementTools();

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

  Future<NoteModel> updateImage(File image, NoteModel noteModel) async {
    if (image == null || noteModel.id == null || noteModel == null) {
      throw ErrorViewModel.newFromMessage("No file specified!");
    } else {
      CollectionReference userDetails = fireStore.collection(_collectionName);
      try {
        if (noteModel != null) {
          if (noteModel.attachment != "") {
            await storageManagementTools
                .deleteFileFromFirebaseStorage(noteModel.attachment);
          }
          String attachment = await storageManagementTools.uploadImage(image);
          noteModel.attachment = attachment;
          await userDetails
              .document(noteModel.id)
              .updateData({attachmentFirebaseColumn: attachment});
        } else {
          throw ErrorViewModel.newFromMessage("No file specified!");
        }
      } catch (e) {
        print(e);
        throw e;
      }
    }
  }
}
