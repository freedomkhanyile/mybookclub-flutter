import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_book_club/screens/root/root.dart';
import 'package:my_book_club/services/auth.dart';
import 'package:my_book_club/widgets/shadowContainer.dart';
import 'package:provider/provider.dart';

class InGroupScreen extends StatefulWidget {
  @override
  _InGroupScreenState createState() => _InGroupScreenState();
}

class _InGroupScreenState extends State<InGroupScreen> {
  //  [0] Time until picked book is due
  //  [1] Time until next book reveal is posted.
  List<String> _timeUntil = List.filled(2, "", growable: false);

  late Timer _timer;

  @override
  void initState() {
    super.initState();
 
  }
 
  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  void _goToAddBook(BuildContext context) async {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => AddBook(
    //       onGroupCreation: false,
    //     ),
    //   ),
    // );
  }

  void _signOut(BuildContext context) async {
     String _returnString = await AuthService().signOut();

    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => OurRoot()), (route) => false);
    }
  }

  void _goToReview() {
     
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => OurReview(
    //       currentGroup: _currentGroup,
    //     ),
    //   ),
    // );
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
