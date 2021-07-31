import 'package:flutter/material.dart';
import 'package:my_book_club/screens/login/localwidgets/loginForm.dart';

class OurLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(32),
                child: Image.asset("assets/logo.jpg"),
              ),
              SizedBox(height:20.0,),
              OurLoginForm()
            ],
          ))
        ],
      ),
    );
  }
}
