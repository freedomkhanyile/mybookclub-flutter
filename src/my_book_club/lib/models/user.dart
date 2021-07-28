import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? fullName;
  Timestamp? accountCreated;

// Create a constructor oop.
  UserModel({this.uid, this.email, this.fullName, this.accountCreated});
}