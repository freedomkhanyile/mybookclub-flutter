import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_book_club/screens/login/login.dart';
 
class OurSignUpForm extends StatelessWidget {
  SizedBox _sizedBox = SizedBox(height: 20.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Sign up",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_outline),
            hintText: "Full name",
          ),
        ),
        _sizedBox,
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.alternate_email),
            hintText: "Email",
          ),
        ),
        _sizedBox,
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline),
            hintText: "Password",
          ),
          obscureText: true,
        ),
        _sizedBox,
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_open),
            hintText: "Confirm Password",
          ),
          obscureText: true,
        ),
        _sizedBox,
        RaisedButton(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Text(
              "Sign up",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          onPressed: () {},
        ),
        FlatButton(
          child: Text("Don't have an account? Log in"),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OurLogin(),
              ),
            );
          },
        )
      ]),
    );
  }
}
