import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_book_club/models/group.dart';

class GroupService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createGroup(String groupName, String createUserId) async {
    String retVal = "error";
    List<String> members = [];

    try {
      members.add(createUserId);
      DocumentReference _docRef = await _firestore.collection("groups").add({
        'name': groupName,
        'leader': createUserId,
        'members': members,
        'groupCreated': Timestamp.now()
      });

      // update the user's group Id
      await _firestore
          .collection("users")
          .doc(createUserId)
          .update({'groupId': _docRef.id});

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> joinGroup(String groupId, String userUid) async {
    String retVal = "error";
    List<String> members = [];

    try {
      // updates the existing members field with our userUid only one can exist by using arrayUnion()
      members.add(userUid);
      await _firestore.collection("groups").doc(groupId).update({
        'members': FieldValue.arrayUnion(members),
      });

      // update the users group Id
      await _firestore
          .collection("users")
          .doc(userUid)
          .update({'groupId': groupId});

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
