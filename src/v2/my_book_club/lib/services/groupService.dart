import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_book_club/models/bookModel.dart';
import 'package:my_book_club/models/groupModel.dart';
import 'package:my_book_club/models/userModel.dart';
import 'package:my_book_club/services/bookService.dart';

class GroupService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<GroupModel> getGroup(String groupId) async {
    GroupModel _group = GroupModel();

    try {
      await _firestore.collection("groups").doc(groupId).get().then((value) {
        _group.id = groupId;
        _group.name = value.data()!["name"];
        _group.leader = value.data()!["leader"];
        _group.members = List<String>.from(value
            .data()!["members"]); // converts a dynamic list to a string array.
        _group.groupCreated = value.data()!["groupCreated"];
        _group.currentBookId = value.data()!["currentBookId"];
      });
    } catch (e) {
      print(e);
    }
    return _group;
  }

  Future<String> createGroup(
      String groupName, UserModel user, BookModel initialBook) async {
    String retVal = "error";

    List<String> members = [];
    List<String> tokens = [];

    try {
      members.add(user.uid!);
      tokens.add(user.notifToken!);
      DocumentReference _docRef;
      if (user.notifToken != null) {
        _docRef = await _firestore.collection("groups").add({
          'name': groupName.trim(),
          'leader': user.uid!,
          'members': members,
          'tokens': tokens,
          'groupCreated': Timestamp.now(),
          'nextBookId': "waiting",
          'indexPickingBook': 0
        });
      } else {
        _docRef = await _firestore.collection("groups").add({
          'name': groupName.trim(),
          'leader': user.uid!,
          'members': members,
          'groupCreated': Timestamp.now(),
          'nextBookId': "waiting",
          'indexPickingBook': 0
        });
      }

      // update the user's group Id
      await _firestore
          .collection("users")
          .doc(user.uid!)
          .update({'groupId': _docRef.id});

      // add a book
      BookService().addBook(_docRef.id, initialBook);

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> joinGroup(String groupId, UserModel user) async {
    String retVal = "error";
    List<String> members = [];
    List<String> tokens = [];

    try {
      // updates the existing members field with our userUid only one can exist by using arrayUnion()
      members.add(user.uid!);
      tokens.add(user.notifToken!);

      await _firestore.collection("groups").doc(groupId).update({
        'members': FieldValue.arrayUnion(members),
        'tokens': FieldValue.arrayUnion(tokens),
      });

      // update the users group Id
      await _firestore
          .collection("users")
          .doc(user.uid!)
          .update({'groupId': groupId.trim()});

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> leaveGroup(String groupId, UserModel userModel) async {
    String retVal = "error";
    List<String> members = [];
    List<String> tokens = [];

    try {
      members.add(userModel.uid!);
      tokens.add(userModel.notifToken!);

      await _firestore.collection("groups").doc(groupId).update({
        'members': FieldValue.arrayRemove(members),
        'tokens': FieldValue.arrayRemove(tokens)
      });

      // remove group from user.
      await _firestore
          .collection("users")
          .doc(userModel.uid)
          .update({'groupId': null});

      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
