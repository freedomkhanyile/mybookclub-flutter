import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  String? id;
  String? name;
  int? length;
  Timestamp? completedDate;
  
  BookModel({
    this.id,
    this.name,
    this.length,
    this.completedDate,
  });
}
