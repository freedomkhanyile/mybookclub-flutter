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
        _book.author = value.data()!["author"];
        _book.length = value.data()!["length"];
        _book.completedDate = value.data()!["completedDate"];
      });
    } catch (e) {
      print(e);
    }
    return _book;
  }

  Future<String> addBook(String groupId, BookModel model) async {
    String retVal = "error";

    try {
      DocumentReference _docRef = await _firestore
          .collection("groups")
          .doc(groupId)
          .collection("books")
          .add({
        'name': model.name,
        'author': model.author,
        'length': model.length,
        'completedDate': model.completedDate
      });

      // add current book to group schedule.
      await _firestore.collection("groups").doc(groupId).update(
          {"currentBookId": _docRef.id, "currentBookDue": model.completedDate});

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> finishedBook(
    String groupId,
    String bookId,
    String uid,
    int rating,
    String review,
  ) async {
    String retVal = "error";
    try {
      await _firestore
          .collection("groups")
          .doc(groupId)
          .collection("books")
          .doc(bookId)
          .collection("reviews")
          .doc(uid)
          .set({'rating': rating, 'review': review});
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<bool> isUserDoneWithBook(
    String groupId,
    String bookId,
    String uid,
  ) async {
    bool retVal = false;
    try {
      DocumentSnapshot _docSnapShot = await _firestore
          .collection("groups")
          .doc(groupId)
          .collection("books")
          .doc(bookId)
          .collection("reviews")
          .doc(uid)
          .get();

      if (_docSnapShot.exists) {
        retVal = true;
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
