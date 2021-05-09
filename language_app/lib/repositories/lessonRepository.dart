import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_app/models/lessonModel.dart';
import 'package:language_app/utils/local_storage/storage.dart';

class LessonRepository {
  String _collectionName = "Lesson";

  LessonRepository._();

  static final LessonRepository instance = LessonRepository._();
  Firestore fireStore = Firestore.instance;

  Future<String> addLesson(LessonModel lessonModel) async {
    var user = AppStorage.loggedInUser;
    lessonModel.uid = user.uid;
    if (lessonModel == null) return null;
    try {
      CollectionReference collection = fireStore.collection(_collectionName);
      await collection
          .document(lessonModel.id)
          .setData(LessonModel.toMap(lessonModel));
      return "Success";
    } catch (e) {
      //TODO log error
      print(e);
      return null;
    }
  }

  Future<List<LessonModel>> getUsersLessons(String uid) async {
    if (uid == null) return null;
    try {
      var query = await fireStore
          .collection(_collectionName)
          .where(uidFirebaseColumn, isEqualTo: AppStorage.loggedInUser.uid)
          .getDocuments();
      var output = query.documents;
      List<LessonModel> lessons = [];
      for (var doc in output) {
        lessons.add(LessonModel.newFromFireStore(doc));
      }
      return lessons;
    } catch (e) {
      //TODO log error
      print(e);
      return null;
    }
  }
}
