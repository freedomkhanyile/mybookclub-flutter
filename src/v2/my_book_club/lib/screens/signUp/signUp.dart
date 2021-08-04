import 'package:flutter/material.dart'; 
import 'localWidgets/signUpForm.dart';
 
class SignUp extends StatelessWidget {
  SizedBox _sizedBox = SizedBox(height: 20.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
            padding: EdgeInsets.all(20.0),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BackButton(),
                ],
              ),              
              _sizedBox,
              SignUpForm(),
            ],
          ))
        ],
      ),
    );
  }
}
