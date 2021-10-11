import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_book_club/screens/login/login.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bitmap.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headline4,
              children: [
                TextSpan(text: "We Book "),
                TextSpan(
                  text: "Club.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: RaisedButton(
              child: Text(
                "Start Reading",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              elevation: 0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
