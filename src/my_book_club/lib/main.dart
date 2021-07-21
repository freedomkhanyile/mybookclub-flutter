import 'package:flutter/material.dart';
import 'package:my_book_club/screens/login/login.dart';
import 'package:my_book_club/utils/ourTheme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: OurTheme().buildTheme(),
      debugShowCheckedModeBanner: false,
      home: OurLogin(),
    );
  }
}
