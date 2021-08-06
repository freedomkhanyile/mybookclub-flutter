import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  String? id;
  String? name;
  String? leader;
  List<String>? members;
  List<String>? tokens;
  Timestamp? groupCreated;
  String? currentBookId;
  int? indexPickingBook;
  String? nextBookId;

  GroupModel({
    this.id,
    this.name,
    this.leader,
    this.members,
    this.tokens,
    this.groupCreated,
    this.currentBookId,
    this.indexPickingBook,
    this.nextBookId,
  });

  GroupModel.$fromDocumentSnapshot({required DocumentSnapshot doc}) {
    this.id = doc.id;
    if (doc.data() != null) {
      this.name = (doc.data() as Map<String, dynamic>)['name'];
      this.leader = (doc.data() as Map<String, dynamic>)['leader'];
      this.members =
          List<String>.from((doc.data() as Map<String, dynamic>)['members']);
      this.groupCreated = (doc.data() as Map<String, dynamic>)['groupCreated'];
      this.currentBookId =
          (doc.data() as Map<String, dynamic>)['currentBookId'];
      this.indexPickingBook =
          (doc.data() as Map<String, dynamic>)['indexPickingBook'];
      this.nextBookId = (doc.data() as Map<String, dynamic>)['nextBookId'];
    }
  }
}
