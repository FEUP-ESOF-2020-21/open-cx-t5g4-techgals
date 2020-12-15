import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/Initials/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Welcome(),
    );
  }
}


