import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_book_club/screens/book/addBook/addBook.dart';
import 'package:my_book_club/screens/noGroup/noGroup.dart';
import 'package:my_book_club/screens/review/review.dart';
import 'package:my_book_club/screens/root/root.dart';
import 'package:my_book_club/states/currentGroup.dart';
import 'package:my_book_club/states/currentUser.dart';
import 'package:my_book_club/utils/timeLeft.dart';
import 'package:my_book_club/widgets/ourContainer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //  [0] Time until picked book is due
  //  [1] Time until next book reveal is posted.
  List<String> _timeUntil = List.filled(2, "", growable: false);

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    CurrentGroup _currentGroup =
        Provider.of<CurrentGroup>(context, listen: false);

    _currentGroup.updateStateFromDatabase(
        _currentUser.getCurrentUser.groupId!, _currentUser.getCurrentUser.uid!);

    _startTimer(_currentGroup);
  }

  void _startTimer(CurrentGroup currentGroup) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeUntil = OurTimeLeft().timeLeft(currentGroup
            .getCurrentGroup.currentBookDue!
            .toDate()); // function that we call;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  void _goToAddBook(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBook(
          onGroupCreation: false,
        ),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.signOut();

    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => OurRoot()), (route) => false);
    }
  }

  void _goToReview() {
    CurrentGroup _currentGroup =
        Provider.of<CurrentGroup>(context, listen: false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OurReview(
          currentGroup: _currentGroup,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(child: Consumer<CurrentGroup>(
              builder: (BuildContext context, value, Widget? child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(value.getCurrentBook.name ?? "loading..",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: <Widget>[
                          Text("Due In:",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey)),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(_timeUntil[0] ?? "loading..",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: RaisedButton(
                        child: Text("Finished book",
                            style: TextStyle(color: Colors.white)),
                        onPressed:
                            value.getDoneWithCurrentBook ? null : _goToReview,
                      ),
                    ),
                  ],
                );
              },
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Next book revealed in:",
                      style: TextStyle(fontSize: 30, color: Colors.grey)),
                  Text(_timeUntil[1] ?? "loading..",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ],
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
            child: RaisedButton(
                child: Text(
                  "Book club history",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => _goToAddBook(context)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: RaisedButton(
                child: Text("Sign out"),
                color: Theme.of(context).canvasColor,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: BorderSide(
                        color: Theme.of(context).secondaryHeaderColor,
                        width: 2)),
                onPressed: () => _signOut(context)),
          ),
        ],
      ),
    );
  }
}
