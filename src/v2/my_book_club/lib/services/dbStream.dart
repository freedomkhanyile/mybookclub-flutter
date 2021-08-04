import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_book_club/models/groupModel.dart';
import 'package:my_book_club/models/userModel.dart';

class DbStream {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<UserModel> getCurrentUser(String uid) {
    return _firestore.collection("users").doc(uid).snapshots().map(
        (docSnapshot) => UserModel.$fromDocumentSnapshot(doc: docSnapshot));
  }

  Stream<GroupModel> getCurrentGroup(String groupId) {
    return _firestore.collection("groups").doc(groupId).snapshots()
    .map((docSnapshot) => GroupModel.$fromDocumentSnapshot(doc: docSnapshot));
  }
}
