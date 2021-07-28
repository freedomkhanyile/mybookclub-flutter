import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_book_club/models/user.dart';

class UserService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> createUser(UserModel model) async {
    String retVal = "error";

    try {
      await _firestore.collection("users").doc(model.uid).set({
        'fullName': model.fullName,
        'email': model.email,
        'accountCreated': Timestamp.now()
      });

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<UserModel> getUser(String uid) async {
    UserModel _user = UserModel();

    try {
      var _docSnapShot = await _firestore.collection("users").doc(uid).get();
      _user.uid = uid;
      Map<String, dynamic>? data = _docSnapShot.data as Map<String, dynamic>?;
      _user.email = data!["email"];
      _user.fullName = data["fullName"];
      _user.accountCreated = data["accountCreated"];
     } catch (e) {
    print(e);
    }

    return _user;
  }
}
