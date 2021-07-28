import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CurrentUser extends ChangeNotifier {
  String? _uid;
  String? _email;
 
 String? get getUid => _uid;
 
 String? get getEmail => _email;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signUpUser(String email, String password) async {
    bool isSuccess = false;
    try {
      UserCredential _result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password
          );
      if (_result.user != null) {
        isSuccess = true;
      }
    }
    on FirebaseAuthException catch(e) {
      if(e.code == 'weak-password') {
        print('password is too weak');
      } else if(e.code == 'email-already-in-use'){
        print("email is in use");
      }else if(e.code == 'invalid-email'){
        print("email is badly formated");
      }
    }
     catch (e) {
      print(e);
    }
    return isSuccess;
  }

  Future<bool> loginUser(String email, String password) async {
   bool isSuccess = false;
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_result.user != null) {
        _uid = _result.user!.uid;
        _email = _result.user!.email;
        isSuccess = true;
      }
    } catch (e) {
      print(e);
    }
    return isSuccess;
  }
}
