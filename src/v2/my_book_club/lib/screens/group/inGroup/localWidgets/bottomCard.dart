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
  GroupModel _groupModel = GroupModel();
  UserModel _currentUser = UserModel();
  UserModel _pickingUser = UserModel();
  BookModel _nextBook = BookModel();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    _currentUser = Provider.of<UserModel>(context);
    _groupModel = Provider.of<GroupModel>(context);

    if (_groupModel != null) {
      _pickingUser = await UserService()
          .getUser(_groupModel.members![_groupModel.indexPickingBook!]);

      if (_groupModel.nextBookId != "waiting") {
        _nextBook = await BookService()
            .getBook(_groupModel.id!, _groupModel.nextBookId!);
      }

      if (this.mounted) {
        setState(() {});
      }
    }
  }

  void _goToAddBook(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBookScreen(
          onGroupCreation: false,
          onError: false,
          currentUser: _currentUser,
        ),
      ),
    );
  }

  Widget _displayText() {
    Widget retVal;

    if (_pickingUser.uid != null) {
      if (_groupModel.nextBookId == "waiting") {
        if (_pickingUser.uid == _currentUser.uid) {
          retVal = RaisedButton(
            child: Text("Add next book"),
            onPressed: () {
              _goToAddBook(context);
            },
          );
        } else {
          retVal = Text(
            "Waiting for " + _pickingUser.fullName! + " to pick",
            style: TextStyle(fontSize: 30, color: Colors.grey[600]),
          );
        }
      } else {
        retVal = Column(
          children: [
            Text(
              "Next Book Is:",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              (_nextBook != null) ? _nextBook.name! : "loading..",
              style: TextStyle(
                fontSize: 30,
                color: Colors.grey[600],
              ),
            ),
            Text(
              (_nextBook != null) ? _nextBook.author! : "loading..",
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
