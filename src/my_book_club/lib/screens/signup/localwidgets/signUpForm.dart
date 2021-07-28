import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_book_club/screens/login/login.dart';
import 'package:my_book_club/states/currentUser.dart';
import 'package:provider/provider.dart';
 
class OurSignUpForm extends StatefulWidget {
  @override
  _OurSignUpFormState createState() => _OurSignUpFormState();
}

class _OurSignUpFormState extends State<OurSignUpForm> {
  SizedBox _sizedBox = SizedBox(height: 20.0);
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
 
  void _signUpUser(String email, String password, BuildContext context) async{
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      if(await _currentUser.signUpUser(email, password)){
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

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
          controller: _fullNameController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_outline),
            hintText: "Full name",
          ),
        ),
        _sizedBox,
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.alternate_email),
            hintText: "Email",
          ),
        ),
        _sizedBox,
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline),
            hintText: "Password",
          ),
          obscureText: true,
        ),
        _sizedBox,
        TextFormField(
          controller: _confirmPasswordController,
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
          onPressed: () {
            if(_passwordController.text == _confirmPasswordController.text) {
              _signUpUser(_emailController.text, _passwordController.text, context);
            } else {
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text("Passwords do not match"),
                duration: Duration(seconds: 2),
                )
              );
            }
          },
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


