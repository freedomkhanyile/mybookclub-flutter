import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  String? id;
  String? name;
  String? leader;
  List<String>? members;
  Timestamp? groupCreated;
  String? currentBookId;
  Timestamp? currentBookDue;
  // Constructor.
  GroupModel(
      {this.id,
      this.name,
      this.leader,
      this.members,
      this.groupCreated,
      this.currentBookId,
      this.currentBookDue});

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
      this.currentBookDue =
          (doc.data() as Map<String, dynamic>)['currentBookDue'];
    }
  }
}
