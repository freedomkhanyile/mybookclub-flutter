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
  GroupModel({
    this.id,
    this.name,
    this.leader,
    this.members,
    this.groupCreated,
    this.currentBookId,
    this.currentBookDue
  });

}