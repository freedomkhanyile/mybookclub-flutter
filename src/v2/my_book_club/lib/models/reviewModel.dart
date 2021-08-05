import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String? userId;
  int? rating;
  String? review;

  ReviewModel({
    this.userId,
    this.rating,
    this.review,
  });

  ReviewModel.$fromDocumentSnapshot({required DocumentSnapshot doc}) {
    userId = doc.id;
    if (doc.data() != null) {
      this.rating = (doc.data() as Map<String, dynamic>)['rating'];
      this.review = (doc.data() as Map<String, dynamic>)['review'];
    }
 
  }
}
