import 'package:flutter/material.dart';
import 'package:we_book_club/models/userModel.dart';
import 'package:we_book_club/screens/root/root.dart';
import 'package:we_book_club/services/groupService.dart';
import 'package:we_book_club/widgets/shadowContainer.dart';

class JoinGroupScreen extends StatefulWidget {
  final UserModel userModel;

  JoinGroupScreen({required this.userModel});

  @override
  _JoinGroupScreenState createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
  TextEditingController _groupIdController = TextEditingController();

  void _joinGroupScreen(BuildContext context, String groupId) async {
    UserModel _currentUser = widget.userModel;

    String _retVal = await GroupService().joinGroup(groupId, _currentUser);
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
            child: ShadowContainer(
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
                    onPressed: () =>
                        _joinGroupScreen(context, _groupIdController.text),
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
