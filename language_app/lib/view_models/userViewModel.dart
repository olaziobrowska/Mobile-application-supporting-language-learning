import 'package:language_app/models/userModel.dart';

class UserViewModel {
  String uid;
  String email;
  String name;
  String surname;
  String nickname;

  String names() => name + " " + surname;

  UserViewModel._(
      {this.uid, this.email, this.name, this.surname, this.nickname});

  static UserViewModel newFromProperties(
      {String uid,
      String email,
      String name,
      String surname,
      String nickname}) {
    return UserViewModel._(
        uid: uid,
        email: email,
        name: name,
        surname: surname,
        nickname: nickname);
  }

  static UserViewModel newFromUserModel(UserModel userModel) {
    return UserViewModel._(
        uid: userModel.id,
        email: userModel.email,
        name: userModel.name,
        surname: userModel.surname,
        nickname: userModel.nickname);
  }
}
