import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:we_book_club/models/authModel.dart';
import 'package:we_book_club/models/bookModel.dart';
import 'package:we_book_club/models/groupModel.dart';
import 'package:we_book_club/models/userModel.dart';
import 'package:we_book_club/screens/book/addBook/addBook.dart';
import 'package:we_book_club/screens/reviews/addReview/addReveiw.dart';
import 'package:we_book_club/services/bookService.dart';
import 'package:we_book_club/utils/timeLeft.dart';
import 'package:we_book_club/widgets/book_card_widget.dart';
import 'package:we_book_club/widgets/shadowContainer.dart';
import 'package:provider/provider.dart';

class TopCard extends StatefulWidget {
  @override
  _TopCardState createState() => _TopCardState();
}

class _TopCardState extends State<TopCard> {
  String _timeUntil = "loading..";
  late AuthModel _authModel;
  bool _doneWithBook = true;
  late Timer _timer;
  BookModel _currentBook = BookModel();
  late GroupModel _groupModel;

  // count down to when reading book is due.
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.mounted) {
        setState(() {
          _timeUntil =
              TimeLeft().timeLeft(_groupModel.currentBookDue!.toDate());
        });
      }
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _authModel = Provider.of<AuthModel>(context);

    _groupModel = Provider.of<GroupModel>(context);

    if (_groupModel.id != null) {
      isUserDoneWithBook();
      _currentBook = await BookService()
          .getBook(_groupModel.id!, _groupModel.currentBookId!);

      _startTimer();
    }
  }

  isUserDoneWithBook() async {
    if (await BookService().isUserDoneWithBook(
        _groupModel.id!, _groupModel.currentBookId!, _authModel.uid!)) {
      _doneWithBook = true;
    } else {
      _doneWithBook = false;
    }
  }

  void _goToReview() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddReviewScreen(
          currentGroup: _groupModel,
          uid: _authModel.uid,
        ),
      ),
    );
  }

  void _doNothing() {}

  void _goToAddBook(BuildContext context) {
    UserModel _currentUser = Provider.of<UserModel>(context, listen: false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBookScreen(
          onGroupCreation: false,
          onError: true,
          currentUser: _currentUser,
        ),
      ),
    );
  }

  Widget noNextBook() {
    if (_authModel != null && _groupModel != null) {
      if (_groupModel.currentBookId != "waiting") {
        if (_authModel.uid == _groupModel.leader) {
          return Column(
            children: <Widget>[
              Text(
                "Nobody picked the next book. Leader needs to step in and pick!",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                child: Text("Pick Next Book"),
                onPressed: () => _goToAddBook(context),
                textColor: Colors.white,
              ),
            ],
          );
        } else {
          return Center(
            child: Text(
              "Nobody picked the next book. Leader needs to step in and pick!",
              style: TextStyle(fontSize: 20),
            ),
          );
        }
      } else {
        return Center(
          child: Text("loading..."),
        );
      }
    } else {
      return Center(
        child: Text("loading..."),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    
    if (_currentBook.name == null) {
      return ShadowContainer(child: noNextBook());
    }

    return BookCardWidget(
      book: _currentBook,
      bookDue: _timeUntil,
      press: _doneWithBook ? _doNothing : _goToReview,
      size: size,
    );
  }
}
