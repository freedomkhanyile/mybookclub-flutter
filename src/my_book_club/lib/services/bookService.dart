import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_book_club/models/book.dart';

class BookService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<BookModel> getBook(String groupId, String bookId) async {
    BookModel _book = BookModel();

    try {
      await _firestore
          .collection("groups")
          .doc(groupId)
          .collection("books")
          .doc(bookId)
          .get()
          .then((value) {
        _book.id = bookId;
        _book.name = value.data()!["name"];
        _book.length = value.data()!["length"];
        _book.completedDate = value.data()!["completedDate"];
      });
    } catch (e) {
      print(e);
    }
    return _book;
  }
}
