import 'package:flutter/material.dart';
import 'package:my_book_club/screens/book/addBook/addBook.dart';
import 'package:my_book_club/screens/root/root.dart';
import 'package:my_book_club/services/groupService.dart';
import 'package:my_book_club/states/currentUser.dart';
import 'package:my_book_club/widgets/ourContainer.dart';
import 'package:provider/provider.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  TextEditingController _groupNameController = TextEditingController();

  void _goToAddBook(BuildContext context, String groupName) async { 
   
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddBook(
            onGroupCreation: true,
            groupName: groupName,
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
            child: OurContainer(
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
