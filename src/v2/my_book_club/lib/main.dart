// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_book_club/models/authModel.dart';
import 'package:my_book_club/screens/root/root.dart';
import 'package:my_book_club/services/auth.dart';
import 'package:my_book_club/utils/ourTheme.dart'; 
import 'package:provider/provider.dart';
// Import the firebase_core plugin
 void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthModel>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        theme: OurTheme().buildTheme(),
        debugShowCheckedModeBanner: false,
        home: OurRoot(),
      ),
    );
  }
}


