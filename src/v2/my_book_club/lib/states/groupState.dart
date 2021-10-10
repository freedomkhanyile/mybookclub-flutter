import 'package:flutter/cupertino.dart';
import 'package:we_book_club/services/bookService.dart';

class GroupState extends ChangeNotifier {
  
  void finishedBook(
    String groupId,
    String currentBookId,
    String uid,
    int rating,
    String review,
  ) async {
    try {
      await BookService()
          .finishedBook(groupId, currentBookId, uid, rating, review);
       notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
