import 'package:flutter/material.dart';
import 'package:proj_src/Screens/Menu/screen_menu.dart';
import 'package:proj_src/Screens/Profile/screen_profile.dart';
import 'package:proj_src/constants.dart';

AppBar buildAppBar_Map(context) {
  return AppBar(
    elevation: 50,
    backgroundColor: kPrimaryColor,
    title: Text("APP_NAME/LOGO?"),
    leading: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) { return Screen_Menu();},),);
      },
      child: Icon(
        Icons.menu,
      ),
    ),
    actions: <Widget>[
      GestureDetector(
        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) { return Screen_Profile();},),);},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.account_circle),
        ),
      ),
    ],
  );
}
