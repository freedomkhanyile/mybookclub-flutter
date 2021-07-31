import 'package:flutter/material.dart';
import 'package:my_book_club/screens/root/root.dart';
import 'package:my_book_club/services/groupService.dart';
import 'package:my_book_club/states/currentUser.dart';
import 'package:my_book_club/widgets/ourContainer.dart';
import 'package:provider/provider.dart';

class JoinGroup extends StatefulWidget {
  @override
  _JoinGroupState createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  

  TextEditingController _groupIdController = TextEditingController();

  void _joinGroup(BuildContext context, String groupId) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    String _retVal = await GroupService()
        .joinGroup(groupId, _currentUser.getCurrentUser.uid!);

    if (_retVal == "success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OurRoot(),
          ),
          (route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton()],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _groupIdController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Group Identifier",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70),
                      child: Text(
                        "Join Group",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () => _joinGroup(context, _groupIdController.text),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}