import 'package:flutter/material.dart';
import 'package:my_book_club/screens/noGroup/noGroup.dart';
import 'package:my_book_club/screens/root/root.dart';
import 'package:my_book_club/states/currentUser.dart';
import 'package:my_book_club/widgets/ourContainer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  void _goToNoGroup(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OurNoGroup(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: OurContainer(
                child: Column(
              children: <Widget>[
                Text("No Rules Rules: Netflix and the Culture of Reinvention",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    children: <Widget>[
                      Text("Due In:",
                          style: TextStyle(fontSize: 20, color: Colors.grey)),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text("8 Days",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                    child: Text("Finished book",
                        style: TextStyle(color: Colors.white)),
                    onPressed: () => {})
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: OurContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Next book revealed in:",
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                Text("22 Hours",
                    style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
            child: RaisedButton(
                child: Text(
                  "Book club history",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => _goToNoGroup(context)),
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
