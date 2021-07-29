import 'package:flutter/material.dart';
import 'package:my_book_club/screens/home/home.dart';
import 'package:my_book_club/screens/login/login.dart';
import 'package:my_book_club/screens/noGroup/noGroup.dart';
import 'package:my_book_club/screens/splashScreen/splashScreen.dart';
import 'package:my_book_club/states/currentUser.dart';
import 'package:provider/provider.dart';

enum AuthState { unknown, notLoggedIn, notInGroup, inGroup }

class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthState _authStatus = AuthState.unknown;
  // everytime something changes in the dependencies of this screen this method
  @override
  void didChangeDependencies() async {
    // is triggered.
    super.didChangeDependencies();

    // get the state, check current user, set the authStatus based on the state
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    if (_returnString == "success") {
      // check if the user is in a group.
      if (_currentUser.getCurrentUser.groupId != null) {
        setState(() {
          _authStatus = AuthState.inGroup;
        });
      } else {
        setState(() {
          _authStatus = AuthState.notInGroup;
        });
      }
    } else {
       setState(() {
        _authStatus = AuthState.notLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retWidgetVal = OurLogin();
    switch (_authStatus) {
      case AuthState.unknown:
        retWidgetVal = OurSplashScreen();
        break;
      case AuthState.notLoggedIn:
        retWidgetVal = OurLogin();
        break;
      case AuthState.notInGroup:
        retWidgetVal = OurNoGroup();
        break;
      case AuthState.inGroup:
        retWidgetVal = HomeScreen();
        break;
      default:
    }

    return retWidgetVal;
  }
}
