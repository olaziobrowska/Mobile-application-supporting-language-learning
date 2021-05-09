import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/models/lessonModel.dart';
import 'package:language_app/models/noteModel.dart';
import 'package:language_app/services/notesService.dart';
import 'package:language_app/utils/local_storage/storage.dart';

class NotesViewModel extends ChangeNotifier {
  NotesViewModel._();

  static final NotesViewModel instance = NotesViewModel._();

  final NotesService _service = NotesService.instance;
  LessonModel selectedLesson;
  NoteModel note = NoteModel.empty();

  getNotes() async {
    var noteVariable =
        await _service.getNote(AppStorage.loggedInUser.uid, selectedLesson.id);
    note = noteVariable;
    notifyListeners();
  }

  submitNotes() async {
    try {
      await _service.addNotes(selectedLesson, note);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
