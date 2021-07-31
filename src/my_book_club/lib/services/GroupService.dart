import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_book_club/models/group.dart';

class GroupService {
  
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<GroupModel> getGroup(String groupId) async {
    GroupModel _group = GroupModel();

    try {
      await _firestore.collection("groups").doc(groupId).get().then((value) {
        _group.id = groupId;
        _group.name = value.data()!["name"];
        _group.leader = value.data()!["leader"];
        _group.members = List<String>.from(value.data()!["members"]); // converts a dynamic list to a string array.
        _group.groupCreated = value.data()!["groupCreated"];
        _group.currentBookId = value.data()!["currentBookId"];
        _group.currentBookDue = value.data()!["currentBookDue"];
      });
    } catch (e) {
      print(e);
    }
    return _group;
  }

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
