import 'package:flutter/cupertino.dart';
import 'package:my_book_club/models/book.dart';
import 'package:my_book_club/models/group.dart';
import 'package:my_book_club/services/GroupService.dart';
import 'package:my_book_club/services/bookService.dart';

class CurrentGroup extends ChangeNotifier {
  GroupModel _currentGroup = GroupModel();

  BookModel _currentBook = BookModel();

  bool _doneWithCurrentBook = false;

  GroupModel get getCurrentGroup => _currentGroup;

  BookModel get getCurrentBook => _currentBook;

  bool get getDoneWithCurrentBook => _doneWithCurrentBook;

  void updateStateFromDatabase(
    String groupId,
    String uid,
  ) async {
    try {
      // get the current group
      _currentGroup = await GroupService().getGroup(groupId);

      // get the current book
      _currentBook =
          await BookService().getBook(groupId, _currentGroup.currentBookId!);

      // check if user done with book.
      _doneWithCurrentBook = await BookService()
          .isUserDoneWithBook(groupId, _currentGroup.currentBookId!, uid);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void finishedBook(
    String uid,
    int rating,
    String review,
  ) async {
    try {
      await BookService().finishedBook(
          _currentGroup.id!, _currentGroup.currentBookId!, uid, rating, review);
      _doneWithCurrentBook = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
