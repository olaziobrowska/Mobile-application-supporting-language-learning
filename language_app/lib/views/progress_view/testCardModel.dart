import 'package:intl/intl.dart';
import 'package:language_app/view_models/flashcards/flashcardTestResultViewModel.dart';

class TestCardModel {
  String id;
  String name;
  int percentage;

  TestCardModel(
      this.id,
        this.name,
        this.percentage
  );

  static TestCardModel fromTestResult(FlashcardTestResultViewModel resultViewModel){
    final format = new DateFormat('dd-MM-yyyy hh:mm');
    var name = format.format(resultViewModel.date.toDate());
    return TestCardModel(resultViewModel.points.toString() + " / " + resultViewModel.maxPoints.toString(), name, resultViewModel.points * 100 ~/ resultViewModel.maxPoints);
  }
}
