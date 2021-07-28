 
import 'package:flutter/material.dart';
import 'package:my_book_club/screens/home/home.dart';
import 'package:my_book_club/screens/login/login.dart';
import 'package:my_book_club/states/currentUser.dart';
import 'package:provider/provider.dart';

enum AuthState { notLoggedIn, loggedIn }

class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthState _authStatus = AuthState.notLoggedIn;
   // everytime something changes in the dependencies of this screen this method
  @override
  void didChangeDependencies() async {
   
    // is triggered.
     super.didChangeDependencies();
    
    // get the state, check current user, set the authStatus based on the state
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    if(_returnString == "success") {
      setState(() {
        _authStatus = AuthState.loggedIn;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    Widget retWidgetVal = OurLogin();
    switch (_authStatus) {
      case AuthState.notLoggedIn:
        retWidgetVal = OurLogin();
        break;
      case AuthState.loggedIn:
        retWidgetVal = HomeScreen();
        break;
      default:
    }

    return retWidgetVal;
  }
}
