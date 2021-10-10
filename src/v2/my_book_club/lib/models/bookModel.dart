import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:we_book_club/models/reviewModel.dart';

class BookModel {
  String? id;
  String? name;
  String? author;
  int? length;
  Timestamp? completedDate;
  List<ReviewModel>? reviews;
  
  BookModel({
    this.id,
    this.name,
    this.author,
    this.length,
    this.completedDate,
    this.reviews
  });

  BookModel.$fromDocumentSnapshot({required DocumentSnapshot doc}) {
    this.id = doc.id;
    if (doc.data() != null) {
      this.name = (doc.data() as Map<String, dynamic>)['name'];
      this.author = (doc.data() as Map<String, dynamic>)['author'];
      this.length = (doc.data() as Map<String, dynamic>)['length'];
      this.completedDate = (doc.data() as Map<String, dynamic>)['completedDate'];      
      this.reviews =  (doc.data() as Map<String, dynamic>)['reviews'];  
    }
  }

}
