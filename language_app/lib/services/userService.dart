import 'package:firebase_auth/firebase_auth.dart';
import 'package:language_app/models/userModel.dart';
import 'package:language_app/repositories/userRepository.dart';
import 'package:language_app/utils/authorization/authenticationTools.dart';
import 'package:language_app/view_models/userViewModel.dart';

const _weakPasswordMessage = "Entered password is too short";
const _emailMalformedMessage = "Entered email is invalid";
const _emailAlreadyInUseMessage = "Entered email is already used";
const _badCredentialsMessage = "Invalid credentials";
const _accountDisabledMessage = "This account has been disabled";
const _noAccountFoundMessage = "No account found for this email";
const _toManyTriesMessage = "Too many login attempts. Try again later";

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

  Future<String> registerNewUser(String email, String password) async {
    FirebaseUser authNewUser;
    try {
      authNewUser = await _authenticationTools.registerAccount(email, password);
    } on AuthException catch (e) {
      return _handleRegisterException(e);
    }
    if (authNewUser == null) return null;
    var userOutput = await _userRepository
        .addUser(UserModel.newFromEmail(uid: authNewUser.uid, email: email));
    if (userOutput == null) return null;
    return userOutput;
  }

  Future<String> logIn(String email, String password) async {
    FirebaseUser result;
    try {
      result = await _authenticationTools.logIn(email, password);
    } on AuthException catch (e) {
      return _handleLoginException(e);
    }
    if (result == null) return null;
    return result.uid;
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

  String _handleLoginException(AuthException exception) {
    switch (exception.code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_WRONG_PASSWORD":
        return _badCredentialsMessage;
        break;
      case "ERROR_USER_NOT_FOUND":
        return _noAccountFoundMessage;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        return _toManyTriesMessage;
        break;
      case "ERROR_USER_DISABLED":
      case "ERROR_OPERATION_NOT_ALLOWED":
        return _accountDisabledMessage;
        break;
    }
  }

  String _handleRegisterException(AuthException exception) {
    switch (exception.code) {
      case "ERROR_WEAK_PASSWORD":
        return _weakPasswordMessage;
        break;
      case "ERROR_INVALID_EMAIL":
        return _emailMalformedMessage;
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        return _emailAlreadyInUseMessage;
        break;
    }
  }

  Future<String> changeLanguage(String newLanguage) async {
    var user = await getLoggedInUser();
    if (user == null) return null;
    user.languageSelected = newLanguage;
    await _userRepository.editUser(UserModel.newFromViewModel(user));
    return "Success";
  }
}
