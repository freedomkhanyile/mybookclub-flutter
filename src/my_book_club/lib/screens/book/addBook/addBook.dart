import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_book_club/models/book.dart';
import 'package:my_book_club/screens/root/root.dart';
import 'package:my_book_club/services/groupService.dart';
import 'package:my_book_club/states/currentUser.dart';
import 'package:my_book_club/widgets/ourContainer.dart';
import 'package:provider/provider.dart';

class AddBook extends StatefulWidget {
  final bool onGroupCreation;
  final String groupName;

  AddBook({
    required this.onGroupCreation,
    required this.groupName,
  });

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _lengthController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await DatePicker.showDateTimePicker(context,
        showTitleActions: true); // using the datepicker plugin

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _createGroup(
      BuildContext context, String groupName, BookModel book) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    String _retVal = await GroupService()
        .createGroup(groupName, _currentUser.getCurrentUser.uid!, book);

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
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton()],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.book),
                      hintText: "Book Name",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _authorController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Book Author",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _lengthController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.library_books),
                      hintText: "Page Length",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // datepicker (package)

                  Text(DateFormat.yMMMMd("en_US").format(selectedDate)),
                  Text(DateFormat("H:mm").format(selectedDate)),
                  FlatButton(
                    child: Text("Change Date"),
                    onPressed: () => _selectDate(context),
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Text(
                        "Create",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      BookModel book = BookModel();
                      book.name = _nameController.text;
                      book.author = _authorController.text;
                      book.length = int.parse(_lengthController.text);
                      book.completedDate = Timestamp.fromDate(selectedDate);
                      _createGroup(context, widget.groupName, book);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
