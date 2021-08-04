import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_book_club/models/authModel.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

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
 
        // String _returnString = await UserService().createUser(_user);
        // if (_returnString == "success") {
        //   retVal = "success";
        // }
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
          email: email, password: password);

      if (_result.user != null) {
        // _currentUser = await UserService().getUser(_result.user!.uid);
        // // check if user state is not null;
        // if (_currentUser.email != null) {
        //   retVal = "success";
        // }
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
        // UserService().createUser(_user);
      }
      // _currentUser = await UserService().getUser(_result.user!.uid);
      // // check if user state is not null;
      // if (_currentUser.email != null) {
      //   retVal = "success";
      // }
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
