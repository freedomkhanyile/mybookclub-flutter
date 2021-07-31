import 'package:flutter/cupertino.dart';
import 'package:my_book_club/models/book.dart';
import 'package:my_book_club/models/group.dart';
import 'package:my_book_club/services/GroupService.dart';
import 'package:my_book_club/services/bookService.dart';

class CurrentGroup extends ChangeNotifier {
  GroupModel _currentGroup = GroupModel();

  BookModel _currentBook = BookModel();

  GroupModel get getCurrentGroup => _currentGroup;

  BookModel get getCurrentBook => _currentBook;

  void updateStateFromDatabase(String groupId) async {
    try {
      // get the current group
      _currentGroup = await GroupService().getGroup(groupId);

      // get the current book 
      _currentBook =
          await BookService().getBook(groupId, _currentGroup.currentBookId!);

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
