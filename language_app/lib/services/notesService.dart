import 'package:language_app/models/lessonModel.dart';
import 'package:language_app/models/noteModel.dart';
import 'package:language_app/repositories/notesRepository.dart';

class NotesService {
  NotesService._();

  static final NotesService instance = NotesService._();

  final NotesRepository _repository = NotesRepository.instance;

  Future<void> addNotes(LessonModel lessonModel, NoteModel noteModel) async {
    try {
      if (noteModel.id == null || noteModel.id == "") {
        await _repository.addNote(lessonModel, noteModel);
      } else {
        await _repository.editNote(noteModel);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<NoteModel> getNote(String uid, String lessonModelId) async {
    try {
      return await _repository.getNotesByLessonId(uid, lessonModelId);
    } catch (e) {
      throw e;
    }
  }
}
