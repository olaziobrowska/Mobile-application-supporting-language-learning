import 'package:firebase_auth/firebase_auth.dart';
import 'package:language_app/models/userModel.dart';
import 'package:language_app/repositories/userRepository.dart';
import 'package:language_app/utils/authorization/authenticationTools.dart';
import 'package:language_app/utils/local_storage/storage.dart';
import 'package:language_app/view_models/userViewModel.dart';

class UserService {
  UserService._();

  static final UserService instance = UserService._();

  UserRepository _userRepository = UserRepository.instance;
  AuthenticationTools _authenticationTools = AuthenticationTools.instance;

  Future<UserViewModel> getLoggedInUser() async {
    var authUser = await _authenticationTools.getLoggedInUser();
    if (authUser == null) return null;
    var customUser = await _userRepository.getUserByUID(authUser.uid);
    if (customUser == null) return null;
    return UserViewModel.newFromUserModel(customUser);
  }

  Future<String> getLoggedInUserUID() async {
    var authUser = await _authenticationTools.getLoggedInUser();
    if (authUser == null) return null;
    return authUser.uid;
  }

  Future<String> registerNewUser(String email, String password, String name, String surname) async {
    List authNewUser;
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = name; // temp solution?
    authNewUser = await _authenticationTools.registerAccount(email, password);
    if (authNewUser[0] == null) return authNewUser[1];
    await authNewUser[0].updateProfile(updateInfo);
    var userOutput = await _userRepository
        .addUser(UserModel.newFromEmail(uid: authNewUser[0].uid, email: email, name: name, surname: surname));
    if (userOutput == null) return null;
    return userOutput;
  }
  Future<List> logIn(String email, String password) async {
    List result;
    result = await _authenticationTools.logIn(email, password);
    if (result[0] == null) return [result[1], null];
    AppStorage.loggedInUser = await getLoggedInUser();
    return [result[0].uid, "Success"];
  }

  Future<String> setUserData(
      String name, String surname, String nickname) async {
    var authUID = await getLoggedInUserUID();
    if (authUID == null) return null;
    var result = await _userRepository.editUser(UserModel.newFromEmail(
        uid: authUID, nickname: nickname, name: name, surname: surname));
    return result;
  }

  Future<UserViewModel> getUserDataByEmail(String email) async {
    var user = await _userRepository.getUserByEmail(email);
    if (user == null) return null;
    return UserViewModel.newFromUserModel(user);
  }

  Future<UserViewModel> getUserDataByUID(String uid) async {
    var user = await _userRepository.getUserByUID(uid);
    if (user == null) return null;
    return UserViewModel.newFromUserModel(user);
  }
}
