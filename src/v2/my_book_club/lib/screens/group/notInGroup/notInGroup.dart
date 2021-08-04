import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_book_club/screens/root/root.dart';
import 'package:my_book_club/services/auth.dart';
import 'package:my_book_club/widgets/shadowContainer.dart'; 
import 'package:provider/provider.dart';

class NotInGroupScreen extends StatefulWidget {
  @override
  _NotInGroupScreenState createState() => _NotInGroupScreenState();
}

class _NotInGroupScreenState extends State<NotInGroupScreen> {
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
    super.dispose();
  }

  void _signOut(BuildContext context) async {
    String _returnString = await AuthService().signOut();

    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => OurRoot()), (route) => false);
    }
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
            child: ShadowContainer(
              child: Padding(
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
            ),
          ),
        ],
      ),
    );
  }
}
