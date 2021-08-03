import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  String? uid;
  String? email;
  // Constructor.
  AuthModel({
    this.uid,
    this.email,
  });

  // Named constructor

  AuthModel.$FromFirebaseUser({required User user}) {
    this.uid = user.uid;
    this.email = user.email;
  }

}
