import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CurrentUser extends ChangeNotifier {
  String? _uid;
  String? _email;

  String? get getUid => _uid;

  String? get getEmail => _email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser(String email, String password) async {
    String retVal =
        "error"; // by defaulting this to a negative we can test effectively.
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      retVal = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        retVal = "password is too weak";
      } else if (e.code == 'email-already-in-use') {
        retVal = "email is in use";
      } else if (e.code == 'invalid-email') {
        retVal = "email is badly formated";
      } else {
        retVal = e.message;
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = "error invalid username/password";
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _uid = _result.user!.uid;
      _email = _result.user!.email;
      retVal = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        retVal = "This account does not exist!";
      }  
    } catch (e) {
      retVal = "Something went wrong, contact sys admin!";
      print(e);
    }
    return retVal;
  }
}
