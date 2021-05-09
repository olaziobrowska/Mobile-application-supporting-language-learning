import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/models/lessonModel.dart';
import 'package:language_app/models/userModel.dart';
import 'package:language_app/services/lessonService.dart';
import 'package:language_app/utils/local_storage/storage.dart';

class LessonsViewModel extends ChangeNotifier {
  LessonsViewModel._();

  static final LessonsViewModel instance = LessonsViewModel._();

  final LessonService _service = LessonService.instance;
  List<LessonModel> userLessons = [];
  LessonModel addLesson = LessonModel.newLesson(
      userModel: UserModel.newFromViewModel(AppStorage.loggedInUser));

  Future<void> addNewLesson() async {
    try {
      await _service.addLesson(addLesson);
      await getUsersLesson();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> getUsersLesson() async {
    userLessons = await _service.getLessons(AppStorage.loggedInUser.uid);
    notifyListeners();
  }
}
