import 'package:flutter/material.dart';

class OurLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(32),
                child: Image.asset("assets/logo.jpg"),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
