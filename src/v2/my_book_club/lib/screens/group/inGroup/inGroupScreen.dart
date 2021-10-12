import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:we_book_club/models/groupModel.dart';
import 'package:we_book_club/models/userModel.dart';
import 'package:we_book_club/screens/book/addBook/addBook.dart';
import 'package:we_book_club/screens/book/bookHistory/bookHistory.dart';
import 'package:we_book_club/screens/group/inGroup/localWidgets/bottomCard.dart';
import 'package:we_book_club/screens/group/inGroup/localWidgets/topCard.dart';
import 'package:we_book_club/screens/reviews/addReview/addReveiw.dart';

import 'package:we_book_club/screens/root/root.dart';
import 'package:we_book_club/services/auth.dart';
import 'package:we_book_club/services/groupService.dart';
import 'package:we_book_club/utils/ourTheme.dart';
import 'package:we_book_club/widgets/book_card_widget.dart';

import 'package:we_book_club/widgets/shadowContainer.dart';
import 'package:provider/provider.dart';

class InGroupScreen extends StatefulWidget {
  @override
  _InGroupScreenState createState() => _InGroupScreenState();
}

class _InGroupScreenState extends State<InGroupScreen> {
  final key = new GlobalKey<ScaffoldState>();
  UserModel? _currentUser;
  @override
  void didChangeDependencies() {
    _currentUser = Provider.of<UserModel>(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _signOut(BuildContext context) async {
    String _returnString = await AuthService().signOut();

    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => OurRoot(),
        ),
        (route) => false,
      );
    }
  }

  void _leaveGroup(BuildContext context) async {
    GroupModel group = Provider.of<GroupModel>(context, listen: false);
    UserModel user = Provider.of<UserModel>(context, listen: false);

    String _returnString = await GroupService().leaveGroup(group.id!, user);

    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => OurRoot(),
        ),
        (route) => false,
      );
    }
  }

  void _copyGroupId(BuildContext context) {
    GroupModel group = Provider.of<GroupModel>(context, listen: false);
    Clipboard.setData(ClipboardData(text: group.id));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Group ID Copied!"),
      backgroundColor: HexColor("#71A748"),
    ));
  }

  void _goToBookHistory() {
    GroupModel group = Provider.of<GroupModel>(context, listen: false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookHistoryScreen(
          groupId: group.id!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/main_page_bg.png",
                  ),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * .1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color: Colors.grey.withOpacity(0.75)),
                              children: [
                                TextSpan(text: "Welcome! \n"),
                                TextSpan(
                                  text: (_currentUser != null)
                                      ? _currentUser!.fullName
                                      : "anonymous",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ]),
                        ),
                        IconButton(
                          onPressed: () => _signOut(context),
                          icon: Icon(Icons.exit_to_app),
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.black),
                        children: [
                          TextSpan(text: "Ready for \ntoday's "),
                          TextSpan(
                            text: "reading?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopCard(),
                          SizedBox(height: 20),
                          // Action buttons.
                          RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.headline6,
                              children: [
                                TextSpan(
                                    text: "Quick ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300)),
                                TextSpan(
                                  text: "Actions",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              child: Text(
                                "Book Club History",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () => _goToBookHistory(),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              child: Text("Copy Group Id"),
                              onPressed: () => _copyGroupId(context),
                              color: Theme.of(context).canvasColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: FlatButton(
                              child: Text("Leave Group"),
                              onPressed: () => _leaveGroup(context),
                              color: Theme.of(context).canvasColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
