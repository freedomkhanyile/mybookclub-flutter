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
      await _firestore.collection("users").doc(uid).get().then((value) {
        _user.uid = uid;
        _user.fullName = value.data()!["fullName"];
        _user.email = value.data()!["email"];
        _user.accountCreated = value.data()!["accountCreated"];
        _user.groupId = value.data()!["groupId"];
      }); 
    } catch (e) {
      print(e);
    }

    return _user;
  }
}
