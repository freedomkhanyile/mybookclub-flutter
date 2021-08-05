import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_book_club/models/authModel.dart';
import 'package:my_book_club/models/userModel.dart';
import 'package:my_book_club/services/userService.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Stream<AuthModel?> get user {
    return _auth.authStateChanges().map(
          (User? firebaseUser) => (firebaseUser != null)
              ? AuthModel.$FromFirebaseUser(user: firebaseUser)
              : null,
        );
  }

  Future<String> signOut() async {
    String retVal = "error";
    try {
      await _auth.signOut();
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signUpUser(
      String fullName, String email, String password) async {
    String retVal =
        "error"; // by defaulting this to a negative we can test effectively.
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserModel _user = UserModel(
        uid: _authResult.user!.uid,
        email: _authResult.user!.email,
        fullName: fullName.trim(),
        accountCreated: Timestamp.now(),
        notifToken: await _fcm.getToken(),
      );

      String _returnString = await UserService().createUser(_user);

      if (_returnString == "success") {
        retVal = "success";
      }

      retVal = "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        retVal = "password is too weak";
      } else if (e.code == 'email-already-in-use') {
        retVal = "email is in use";
      } else if (e.code == 'invalid-email') {
        retVal = "email is badly formated";
      } else {
        retVal = e.message!;
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
          email: email.trim(), password: password);
      if (_result.user != null) {
        retVal = "success";
      } else {
        print("Something went wrong! contact sys admin");
      }
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

  Future<String> loginUserWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    String retVal = "error";

    try {
      GoogleSignInAccount? _googleUser =
          await _googleSignIn.signIn(); // signs user to the google account

      // creates a firebase Google account.
      GoogleSignInAuthentication _googleAuth =
          await _googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      UserCredential _result = await _auth.signInWithCredential(credential);

      if (_result.additionalUserInfo!.isNewUser) {
        UserModel _user = UserModel(
          uid: _result.user!.uid,
          email: _result.user!.email,
          fullName: _result.user!.displayName,
          accountCreated: Timestamp.now(),
          notifToken: await _fcm.getToken(),
        );

        String _returnString = await UserService().createUser(_user);

        if (_returnString == "success") {
          retVal = "success";
        }
      }
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
