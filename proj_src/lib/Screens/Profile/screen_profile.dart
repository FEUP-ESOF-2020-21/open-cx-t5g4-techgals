import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/auth.dart';
import 'package:proj_src/Screens/Initials/welcome.dart';
import 'package:proj_src/Screens/Nav/Components/appBar.dart';
import 'package:proj_src/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  AuthMethods authMethods = new AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 50,
        backgroundColor: kPrimaryColor,
        title: Text("APP_NAME/LOGO?"),
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
      ),
    );
  }
}


/*
class Screen_Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: buildAppBar_Map(),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          "PROFILE PAGE",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
*/