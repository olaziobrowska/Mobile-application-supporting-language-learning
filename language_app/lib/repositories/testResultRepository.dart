import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_app/models/flashcards/flashcardTestResultModel.dart';
import 'package:language_app/utils/local_storage/storage.dart';
import 'package:language_app/view_models/errorViewModel.dart';

class TestResultRepository {
  TestResultRepository._();

  static final TestResultRepository instance = TestResultRepository._();
  final Firestore _fireStore = Firestore.instance;

  String _collectionName = "TestResult";

  Future<void> addNewTestResult(FlashcardTestResultModel testModel) async {
    if (testModel == null)
      throw ErrorViewModel.newFromMessage("No test result specified!");
    try {
      await _fireStore
          .collection(_collectionName)
          .add(FlashcardTestResultModel.toMap(testModel));
    } catch (e) {
      throw e;
    }
  }

  Future<void> editTestResult(FlashcardTestResultModel testModel) async {
    if (testModel == null || testModel.id == null)
      throw ErrorViewModel.newFromMessage("No test result specified!");
    try {
      await _fireStore
          .collection(_collectionName)
          .document(testModel.id)
          .setData(FlashcardTestResultModel.toMap(testModel));
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteTestResult(FlashcardTestResultModel testModel) async {
    if (testModel == null || testModel.id == null)
      throw ErrorViewModel.newFromMessage("No test result specified!");
    try {
      await _fireStore
          .collection(_collectionName)
          .document(testModel.id)
          .delete();
    } catch (e) {
      throw e;
    }
  }

  Future<List<FlashcardTestResultModel>> getUsersTestResults() async {
    if (AppStorage.loggedInUser == null)
      throw ErrorViewModel.newFromMessage("No logged in user!");
    try {
      var output = await _fireStore
          .collection(_collectionName)
          .where(uidFirebaseColumn, isEqualTo: AppStorage.loggedInUser.uid)
          .getDocuments();
      List<FlashcardTestResultModel> tests = [];
      for (var doc in output.documents) {
        tests.add(FlashcardTestResultModel.newFromFireStore(doc));
      }
      return tests;
    } catch (e) {
      throw e;
    }
  }
}
