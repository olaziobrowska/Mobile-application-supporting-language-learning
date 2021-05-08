import 'package:language_app/models/lessonModel.dart';
import 'package:language_app/repositories/lessonRepository.dart';
import 'package:language_app/utils/local_storage/storage.dart';

class LessonService {
  LessonService._();

  static final LessonService instance = LessonService._();

  final LessonRepository _repository = LessonRepository.instance;

  Future<void> addLesson(LessonModel lessonModel) async {
    try {
      var number = (await getLessons(AppStorage.loggedInUser.uid)).length + 1;
      lessonModel.name = "Lesson " + number.toString();
      await _repository.addLesson(lessonModel);
    } catch (e) {
      throw e;
    }
  }

  Future<List<LessonModel>> getLessons(String uid) async {
    try {
      return await _repository.getUsersLessons(uid);
    } catch (e) {
      throw e;
    }
  }
}
