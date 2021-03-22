import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationTools {
  AuthenticationTools._();

  static final AuthenticationTools instance = AuthenticationTools._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> getLoggedInUser() async {
    try{
      return await firebaseAuth.currentUser();
    }
    catch(e){
      //TODO log error
      print(e);
      return null;
    }
  }

  Future<FirebaseUser> logIn(String email, String password) async {
    if(email == null || email == "" || password == null || password == "") return null;
    try{
      var output = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return output.user;
    }
    catch(e){
      //TODO Log error
      print(e);
      return null;
    }
  }

  Future<FirebaseUser> registerAccount(String email, String password) async {
    if(email == null || email == "" || password == null || password == "") return null;
    try{
      var output = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return output.user;
    }
    catch(e){
      //TODO Log error
      print(e);
      return null;
    }
  }

  Future<String> signOut() async {
    try {
      await firebaseAuth.signOut();
      //Add on remembering login:
      //final SharedPreferences prefs = await SharedPreferences.getInstance();
      //prefs.remove('email');
      return "Success";
    } catch (e) {
      //TODO Log error
      print(e);
      return "Failure";
    }
  }


}