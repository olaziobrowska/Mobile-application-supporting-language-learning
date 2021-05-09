import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _weakPasswordMessage = "Entered password is too short";
const _emailMalformedMessage = "Entered email is invalid";
const _emailAlreadyInUseMessage = "Entered email is already used";
const _badCredentialsMessage = "Invalid credentials";
const _accountDisabledMessage = "This account has been disabled";
const _noAccountFoundMessage = "No account found for this email";
const _toManyTriesMessage = "Too many login attempts. Try again later";


class AuthenticationTools {
  AuthenticationTools._();

  static final AuthenticationTools instance = AuthenticationTools._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> getLoggedInUser() async {
    try {
      return await firebaseAuth.currentUser();
    } catch (e) {
      //TODO log error
      print(e);
      return null;
    }
  }

  Future<List> logIn(String email, String password) async {
    if (email == null || email == "" || password == null || password == "")
      return null;
    try {
      var output = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return [output.user, "Success"];
    } on AuthException catch (e) {
      throw e;
    } catch (e) {
      print(e);
      return [null, _handleLoginException(e)];
    }
  }


  Future<List> registerAccount(String email, String password) async {
    if (email == null || email == "" || password == null || password == "")
      return null;
    try {
      var output = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return [output.user, "Success"];
    } on AuthException catch (e) {
      throw e;
    }
    catch (e) {
      print(e);
      return [null, _handleRegisterException(e)];
    }
  }

  Future<String> signOut() async {
    try {
      await firebaseAuth.signOut();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('email');
      return "Success";
    } catch (e) {
      //TODO Log error
      print(e);
      return "Failure";
    }
  }

  String _handleLoginException(PlatformException exception) {
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

  String _handleRegisterException(PlatformException exception) {
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
}
