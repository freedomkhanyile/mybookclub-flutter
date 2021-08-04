import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_book_club/models/authModel.dart';
import 'package:my_book_club/models/groupModel.dart';
import 'package:my_book_club/models/userModel.dart';
import 'package:my_book_club/screens/group/inGroup/inGroupScreen.dart';
import 'package:my_book_club/screens/group/notInGroup/noGroup.dart';
import 'package:my_book_club/screens/login/login.dart';
import 'package:my_book_club/screens/splashScreen/splashScreen.dart';
import 'package:my_book_club/services/dbStream.dart';
import 'package:provider/provider.dart';

enum AuthState { unknown, notLoggedIn, loggedIn }

class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthState _authStatus = AuthState.unknown;
  String currentUid = "";
  // everytime something changes in the dependencies of this screen this method
  @override
  void didChangeDependencies() async {
    // is triggered.
    super.didChangeDependencies();

    // get the state, check current user, set the authStatus based on the state
    AuthModel _authStreamState = Provider.of<AuthModel>(context);
    if (_authStreamState != null) {
      // check if the user is in a group.
      setState(() {
        _authStatus = AuthState.loggedIn;
        currentUid = _authStreamState.uid!;
      });
    } else {
      setState(() {
        _authStatus = AuthState.notLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retWidgetVal = Scaffold(
      body: Center(
        child: Text("Default"),
      ),
    );
    switch (_authStatus) {
      case AuthState.unknown:
        // retWidgetVal = OurSplashScreen();
        retWidgetVal = SplashScreen();
        break;
      case AuthState.notLoggedIn:
        retWidgetVal = Login();
        break;
      case AuthState.loggedIn:
        retWidgetVal = StreamProvider<UserModel>.value(
          value: DbStream().getCurrentUser(currentUid),
          initialData: UserModel(),
          child: LoggedIn(),
        );
        break;

      default:
    }

    return retWidgetVal;
  }
}

class LoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget retWidgetVal;

    UserModel _userStream = Provider.of<UserModel>(context);

    // if in a group.
    if (_userStream.email != null) {
      if (_userStream.groupId != null) {
        retWidgetVal = StreamProvider<GroupModel>.value(
          value: DbStream().getCurrentGroup(_userStream.groupId!),
          initialData: GroupModel(),
          child: InGroupScreen());
      } else {
        retWidgetVal = NoGroupScreen();
      }
    }  else {
      retWidgetVal = SplashScreen();
    }

    return retWidgetVal;
  }
}
