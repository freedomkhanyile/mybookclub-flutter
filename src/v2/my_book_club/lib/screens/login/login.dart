import 'package:flutter/material.dart';
import 'localWidgets/loginForm.dart';

class Login extends StatelessWidget {
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
                child: Image.asset("assets/Jotta-logo.png", width: 150, height: 150,),
              ),
              SizedBox(height:20.0,),
              LoginForm()
            ],
          ))
        ],
      ),
    );
  }
}
