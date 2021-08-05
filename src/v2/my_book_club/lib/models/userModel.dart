import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? email;
  String? fullName;
  Timestamp? accountCreated;
  String? groupId;
  String? notifToken;
  // Constructor.
  UserModel({
    this.uid,
    this.email,
    this.fullName,
    this.accountCreated,
    this.groupId,
    this.notifToken,
  });

  // Named constructor

  UserModel.$fromDocumentSnapshot({required DocumentSnapshot doc}) {
    this.uid = doc.id;
    this.email = (doc.data() as Map<String, dynamic>)['email'];
    this.fullName = (doc.data() as Map<String, dynamic>)['fullName'];
    this.accountCreated =
        (doc.data() as Map<String, dynamic>)['accountCreated'];
    this.groupId = (doc.data() as Map<String, dynamic>)['groupId'];
    this.notifToken = (doc.data() as Map<String, dynamic>)['notifToken'];
  }
}
