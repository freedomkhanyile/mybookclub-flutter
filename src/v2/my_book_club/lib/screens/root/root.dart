import 'package:flutter/material.dart';
import 'package:my_book_club/models/authModel.dart';
import 'package:my_book_club/screens/group/notInGroup/notInGroup.dart';
import 'package:my_book_club/screens/login/login.dart';
import 'package:my_book_club/screens/splashScreen/splashScreen.dart';
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
    AuthModel _authStreamState = Provider.of<AuthModel>(context);
    if (_authStreamState != null) {
      // check if the user is in a group.
      setState(() {
        _authStatus = AuthState.notInGroup;
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
      case AuthState.notInGroup:
        // retWidgetVal = OurNoGroup();
        retWidgetVal =  NotInGroupScreen();
        break;
      case AuthState.inGroup:
        // retWidgetVal = ChangeNotifierProvider(
        //   create: (context) =>
        //       CurrentGroup(), // only provide the group state to the home screen.
        //   child: HomeScreen(),
        // );
        retWidgetVal = Scaffold(
          body: Center(
            child: Text("In a group"),
          ),
        );
        break;
      default:
    }

    return retWidgetVal;
  }
}
