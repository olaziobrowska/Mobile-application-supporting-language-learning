import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final String emailFirebaseColumn = "Email";
final String nameFirebaseColumn = "Name";
final String surnameFirebaseColumn = "Surname";
final String nicknameFirebaseColumn = "Nickname";

class UserModel {
  String id;
  String email;
  String nickname;
  String name;
  String surname;

  String names() => name + " " + surname;

  UserModel._({this.id, this.email, this.name, this.nickname, this.surname});

  static UserModel newFromFirebaseUser(
      {FirebaseUser firebaseUser,
      String nickname,
      String name,
      String surname}) {
    if (firebaseUser == null) return null;
    return UserModel._(
        id: firebaseUser.uid,
        email: firebaseUser.email,
        name: name,
        surname: surname,
        nickname: nickname);
  }

  static UserModel newFromEmail(
      {String uid,
      String email,
      String nickname,
      String surname,
      String name}) {
    return UserModel._(
        id: uid,
        email: email,
        nickname: nickname,
        surname: surname,
        name: name);
  }

  static UserModel newFromFireStore(
      DocumentSnapshot document) {
    var map = document.data;
    return UserModel._(
        id: document.documentID,
        email: map[emailFirebaseColumn],
        nickname: map[nicknameFirebaseColumn],
        surname: map[surnameFirebaseColumn],
        name: map[nameFirebaseColumn]);
  }

  static Map<String, dynamic> toMap(UserModel userModel) {
    if (userModel == null) return null;
    Map<String, dynamic> output = Map();
    if (userModel.email != null) output[emailFirebaseColumn] = userModel.email;
    if (userModel.name != null) output[nameFirebaseColumn] = userModel.name;
    if (userModel.nickname != null) output[nicknameFirebaseColumn] = userModel.nickname;
    if (userModel.surname != null) output[surnameFirebaseColumn] = userModel.surname;
    return output;
  }
}
