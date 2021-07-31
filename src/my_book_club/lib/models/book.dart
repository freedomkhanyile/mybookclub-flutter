import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  String? id;
  String? name;
  String? author;
  int? length;
  Timestamp? completedDate;
  
  BookModel({
    this.id,
    this.name,
    this.author,
    this.length,
    this.completedDate,
  });
}
