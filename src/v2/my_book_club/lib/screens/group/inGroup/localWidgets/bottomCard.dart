import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_book_club/models/bookModel.dart';
import 'package:my_book_club/models/groupModel.dart';
import 'package:my_book_club/models/userModel.dart';
import 'package:my_book_club/screens/book/addBook/addBook.dart';
import 'package:my_book_club/services/bookService.dart';
import 'package:my_book_club/services/userService.dart';
import 'package:my_book_club/widgets/shadowContainer.dart';
import 'package:provider/provider.dart';

class BottomCard extends StatefulWidget {
  @override
  _BottomCardState createState() => _BottomCardState();
}

class _BottomCardState extends State<BottomCard> {
  var _groupModel = GroupModel();
  var _currentUser = UserModel();
  var _pickingUser = UserModel();
  var _nextBook = BookModel();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    _currentUser = Provider.of<UserModel>(context);
    _groupModel = Provider.of<GroupModel>(context);

    // ignore: unnecessary_null_comparison
    if (_groupModel != null) {
      _pickingUser = await UserService()
          .getUser(_groupModel.members![_groupModel.indexPickingBook!]);
        _nextBook = await BookService().getBook(_groupModel.id!, _groupModel.nextBookId!);

      setState(() {});
    }
  }

  void _goToAddBook(BuildContext context) {
    int _nextIndex;
    int _numMembers = _groupModel.members!.length;
    if (_groupModel.indexPickingBook == (_numMembers - 1)) {
      _nextIndex = 0; // restart the picking order we reached the end.
    } else {
      _nextIndex = _groupModel.indexPickingBook! + 1;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBookScreen(
          onGroupCreation: false,
          onError: false,
          currentUser: _currentUser,
          nextIndex: _nextIndex,
        ),
      ),
    );
  }

  Widget _displayText() {
    late Widget retVal = Text("");
    // ignore: unnecessary_null_comparison
    if (_pickingUser.uid != null) {
      if (_groupModel.nextBookId == "waiting") {
        if (_pickingUser.uid == _currentUser.uid) {
          // the current user must pick a book
          retVal = RaisedButton(
            child: Text("Select Next Book"),
            onPressed: () {
              _goToAddBook(context);
            },
          );
        } else {
          retVal = Text(
            "Waiting for " + _pickingUser.fullName! + " to pick",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
            ),
          );
        }
      } else {
         
        retVal = Column(
          children: [
            Text(
              "Next book is: ",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
             Text(
           (_nextBook.name != null) ? _nextBook.name! : 'loading..',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            (_nextBook.author! != null) ? _nextBook.author! : 'loading..',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
            ),
          ),
          ],
        );
      }
    } else {
      retVal = Text(
        "Loading...",
        style: TextStyle(
          fontSize: 30,
          color: Colors.grey[600],
        ),
      );
    }

    return retVal;
  }

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: _displayText(),
      ),
    );
  }
}
