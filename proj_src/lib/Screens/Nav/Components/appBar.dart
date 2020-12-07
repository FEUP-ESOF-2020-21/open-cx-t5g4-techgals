import 'package:flutter/material.dart';
import 'package:proj_src/Screens/Initials/welcome.dart';
import 'package:proj_src/Screens/Profile/screen_profile.dart';
import 'package:proj_src/constants.dart';

AppBar buildAppBar_Map(context) {
  return AppBar(
    elevation: 50,
    backgroundColor: kPrimaryColor,
    title: Image.asset("assets/images/logo.PNG", height: 35, width: 200,),
    /*leading: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) { return Screen_Menu();},),);
      },
      child: Icon(
        Icons.menu,
      ),
    ),*/
    leading: new Container(
      padding: EdgeInsets.only(left: 15),
      child: GestureDetector(
        onTap: () {
        },
        child: Icon(
          Icons.refresh_outlined,
        ),
      ),
    ),
    actions: <Widget>[
      GestureDetector(
        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) { return Profile();},),);},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.account_circle),
        ),
      ),
    ],
  );
}

AppBar buildAppBar_Profile(context, authMethods) {
  return AppBar(
    elevation: 50,
    backgroundColor: kPrimaryColor,
    title: Image.asset("assets/images/logo.PNG", height: 35, width: 200,),
    actions: [
      GestureDetector(
        onTap: (){
          authMethods.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (context) { return Welcome();},),);
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.exit_to_app_rounded)
        ),
      )
    ],
  );
}
