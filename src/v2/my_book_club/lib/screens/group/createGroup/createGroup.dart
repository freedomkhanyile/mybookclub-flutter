import 'package:flutter/material.dart';
import 'package:my_book_club/models/userModel.dart';
import 'package:my_book_club/screens/book/addBook/addBook.dart';
import 'package:my_book_club/screens/root/root.dart';

import 'package:my_book_club/widgets/shadowContainer.dart';
import 'package:provider/provider.dart';

class CreateGroupScreen extends StatefulWidget {
   UserModel? currentUser;
   CreateGroupScreen({this.currentUser});
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  UserModel? _currentUser;
  TextEditingController _groupNameController = TextEditingController();
  void _goToAddBook(BuildContext context, String groupName) async {
    _currentUser = widget.currentUser;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBookScreen(
          onGroupCreation: true,
          groupName: groupName,
          currentUser: _currentUser!,
        ),
      ),
    );
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
                    controller: _groupNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Group Name",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 90),
                      child: Text(
                        "Add book",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () =>
                        _goToAddBook(context, _groupNameController.text),
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
