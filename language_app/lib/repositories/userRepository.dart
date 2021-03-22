import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:language_app/models/userModel.dart';

class UserRepository {
  String _collectionName = "UserDetail";

  UserRepository._();

  static final UserRepository instance = UserRepository._();
  Firestore fireStore = Firestore.instance;

  Future<String> addUser(UserModel userModel) async {
    if (userModel == null || userModel.id == null) return null;
    try {
      CollectionReference collection = fireStore.collection(_collectionName);
      await collection
          .document(userModel.id)
          .setData(UserModel.toMap(userModel));
      return "Success";
    } catch (e) {
      //TODO log error
      print(e);
      return null;
    }
  }

  Future<String> editUser(UserModel userModel) async {
    if (userModel == null) return null;
    if (userModel.id == null || userModel.id == "") return "No valid object id";
    try {
      DocumentReference document =
          fireStore.collection(_collectionName).document(userModel.id);
      await document.setData(UserModel.toMap(userModel));
      return "Success";
    } catch (e) {
      //TODO log error
      print(e);
      return null;
    }
  }

  Future<UserModel> getUserByUID(String uid) async {
    if (uid == null || uid == "") return null;
    try {
      DocumentReference document =
          fireStore.collection(_collectionName).document(uid);
      var output = await document.get();
      return UserModel.newFromFireStore(output);
    } catch (e) {
      //TODO log error
      print(e);
      return null;
    }
  }

  Future<UserModel> getUserByEmail(String email) async {
    if (email == null || email == "") return null;
    try {
      var query = await fireStore
          .collection(_collectionName)
          .where(emailFirebaseColumn, isEqualTo: email)
          .getDocuments();
      var output = query.documents[0];
      return UserModel.newFromFireStore(output);
    } catch (e) {
      //TODO log error
      print(e);
      return null;
    }
  }
}
