import 'package:flutter/material.dart';
import 'package:my_book_club/screens/group/createGroup/createGroup.dart';
import 'package:my_book_club/screens/group/joinGroup/joinGroup.dart';

class OurNoGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _goToJoin(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JoinGroup(),
        ),
      );
    }

    void _goToCreate(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateGroup(),
        ),
      );
    }

    return Scaffold(
      body: Column(children: <Widget>[
        Spacer(
          flex: 1,
        ),
        Padding(
          padding: EdgeInsets.all(80.0),
          child: Image.asset("assets/logo.jpg"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            "WELCOME TO MY BOOK CLUB",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            "Since your are not in a book club, you can select join a club or create a club",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey
            ),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                child: Text("Create"),
                color: Theme.of(context).canvasColor,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: BorderSide(
                        color: Theme.of(context).secondaryHeaderColor,
                        width: 2)),
                onPressed: () => _goToCreate(context),
              ),
              RaisedButton(
                child: Text(
                  "Join",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => _goToJoin(context),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
