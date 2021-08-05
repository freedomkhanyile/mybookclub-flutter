import 'package:flutter/material.dart';
import 'package:my_book_club/models/groupModel.dart';
import 'package:my_book_club/services/bookService.dart';
import 'package:my_book_club/states/groupState.dart';
import 'package:my_book_club/widgets/shadowContainer.dart';

class AddReviewScreen extends StatefulWidget {
  final GroupModel currentGroup;
  final String? uid;
  AddReviewScreen({
    required this.currentGroup,
    this.uid,
  });

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  int _dropdownValue = 1;
  TextEditingController _reviewController = TextEditingController();
  void _reviewBook(int rating, String review) {
    if (widget.uid != null) {
      GroupState().finishedBook(
        widget.currentGroup.id!,
        widget.currentGroup.currentBookId!,
        widget.uid!,
        rating,
        review,
      );
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Rate book 1-10:"),
                      DropdownButton<int>(
                        value: _dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Theme.of(context).accentColor),
                        underline: Container(
                          height: 2,
                          color: Theme.of(context).canvasColor,
                        ),
                        onChanged: (int? newValue) {
                          setState(() {
                            _dropdownValue = newValue!;
                          });
                        },
                        items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _reviewController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Add a review",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: Text(
                        "Add review",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      // String uid = Provider.of<CurrentUser>(context, listen: false).getCurrentUser.uid!;
                      // widget.currentGroup.finishedBook(uid, _dropdownValue, _reviewController.text);
                      _reviewBook(_dropdownValue, _reviewController.text);
                      Navigator.pop(context);
                    },
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
