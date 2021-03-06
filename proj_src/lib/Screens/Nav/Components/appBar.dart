import 'package:flutter/material.dart';
import 'package:proj_src/Screens/Initials/welcome.dart';
import 'package:proj_src/Screens/Nav/navigation.dart';
import 'package:proj_src/Screens/Profile/profile.dart';
import 'package:proj_src/constants.dart';

AppBar buildAppBar_Map(context) {
  return AppBar(
    elevation: 50,
    backgroundColor: kPrimaryColor,
    title: Image.asset("assets/images/logo.PNG", height: 35, width: 200,),
    leading: new Container(
      padding: EdgeInsets.only(left: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return NavigationMap();},),);
        },
        child: Icon(
          Icons.refresh_outlined,
        ),
      ),
    ),
    actions: <Widget>[
      GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) { return Profile();},),);
         },
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

AppBar buildAppBar_Simple(context) {
  return AppBar(
    elevation: 50,
    backgroundColor: kPrimaryColor,
    title: Image.asset("assets/images/logo.PNG", height: 35, width: 200,),
  );
}
