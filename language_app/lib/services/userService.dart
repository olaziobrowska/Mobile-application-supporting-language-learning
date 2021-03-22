import 'package:language_app/models/userModel.dart';
import 'package:language_app/repositories/userRepository.dart';
import 'package:language_app/utils/authorization/authenticationTools.dart';
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
    if(customUser== null) return null;
    return UserViewModel.newFromUserModel(customUser);
  }

  Future<String> getLoggedInUserUID() async {
    var authUser = await _authenticationTools.getLoggedInUser();
    if (authUser == null) return null;
    return authUser.uid;
  }

  Future<String> registerNewUser(String email, String password) async {
    var authNewUser =
        await _authenticationTools.registerAccount(email, password);
    if (authNewUser == null) return null;
    var userOutput = await _userRepository
        .addUser(UserModel.newFromEmail(uid: authNewUser.uid, email: email));
    if (userOutput == null) return null;
    return userOutput;
  }

  Future<String> logIn(String email, String password) async {
    var result = await _authenticationTools.logIn(email, password);
    if (result == null) return null;
    return result.uid;
  }

  Future<String> setUserData(
      String name, String surname, String nickname) async {
    var authUID = await getLoggedInUserUID();
    if(authUID == null) return null;
    var result = await _userRepository.editUser(UserModel.newFromEmail(
        uid: authUID, nickname: nickname, name: name, surname: surname));
    return result;
  }
  
  Future<UserViewModel> getUserDataByEmail(String email) async {
    var user = await _userRepository.getUserByEmail(email);
    if(user == null) return null;
    return UserViewModel.newFromUserModel(user);
  }

  Future<UserViewModel> getUserDataByUID(String uid) async {
    var user = await _userRepository.getUserByUID(uid);
    if(user == null) return null;
    return UserViewModel.newFromUserModel(user);
  }
}
