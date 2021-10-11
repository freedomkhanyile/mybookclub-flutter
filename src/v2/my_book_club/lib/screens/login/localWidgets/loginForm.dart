import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_book_club/screens/root/root.dart';
import 'package:we_book_club/screens/signUp/signUp.dart';
import 'package:we_book_club/services/auth.dart';
import 'package:we_book_club/utils/ourTheme.dart';
// import 'package:we_book_club/screens/signup/signup.dart';
// import 'package:we_book_club/states/currentUser.dart';

enum LoginType { email, google }

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  SizedBox _sizedBox = SizedBox(height: 20.0);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _loginUser(
      {required LoginType type,
      String? email,
      String? password,
      BuildContext? context}) async {
    String _returnString = "error";

    try {
      switch (type) {
        case LoginType.email:
          _returnString =
              await AuthService().loginUserWithEmail(email!, password!);
          break;
        case LoginType.google:
          _returnString = await AuthService().loginUserWithGoogle();
          break;
        default:
      }

      if (_returnString == "success") {
        Navigator.pushAndRemoveUntil(
            context!,
            MaterialPageRoute(builder: (context) => OurRoot()),
            (route) => false);
      } else {
        Scaffold.of(context!).showSnackBar(SnackBar(
          content: Text(_returnString),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _googleButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_icon.png"), height: 25.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Sign in with Google",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            )
          ],
        ),
      ),
      // try to put logic at the end of the button less clutter.
      onPressed: () {
        _loginUser(type: LoginType.google, context: context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Log in",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.withOpacity(0.5),
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        TextFormField(
          controller: _emailController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.alternate_email),
            hintText: "Email",
          ),
        ),
        _sizedBox,
        TextFormField(
          controller: _passwordController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline),
            hintText: "Password",
          ),
        ),
        _sizedBox,
        SizedBox(
          width: double.infinity,
          child: RaisedButton(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Log in",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            onPressed: () {
              _loginUser(
                  type: LoginType.email,
                  email: _emailController.text,
                  password: _passwordController.text,
                  context: context);
            },
          ),
        ),
        FlatButton(
          // child: Text("Don't have an account? Sign up here"),
         child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyText1,
              children: [
                TextSpan(text: "Don't have an account? "),
                TextSpan(
                  text: "Sign up",
                  style: TextStyle(
                    color: HexColor("#71A748"),
                  ),
                ),
              ],
            ),
          ), 
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SignUp(),
              ),
            );
          },
        ),
        // TODO Investigate this google sign up button on deployed code.
        // SizedBox(
        //   width: double.infinity,
        //   child: _googleButton(),
        // ),
      ]),
    );
  }
}
