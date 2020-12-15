import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/auth.dart';
import 'package:proj_src/BackEnd/database.dart';
import 'package:proj_src/BackEnd/helper.dart';
import 'package:proj_src/Screens/Initials/initial_aux.dart';
import 'package:proj_src/Screens/Nav/Components/appBar.dart';
import 'package:proj_src/Screens/Profile/interests.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final AuthMethods _authMethods = new AuthMethods();
  User _user = FirebaseAuth.instance.currentUser;
  String userName = '';
  String _email = '';
  bool _emailTaken = false;
  String _newEmail = '';

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  _getInfo() async {
    await HelperFunctions.getUserNameSharedPreference().then((value) {
      setState(() {
        userName = value;
      });
    });
    await HelperFunctions.getUserEmailSharedPreference().then((value) {
      setState(() {
        _email = value;
      });
    });
  }
  _checkEmail(String email) async{
    QuerySnapshot _emailQS;
    await DatabaseMethods().emailTaken(email).then((value) {
      setState(() {
        _emailQS = value;
      });
    });
    if(_emailQS.size == 0) _emailTaken = false;
    else _emailTaken = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar_Profile(context, _authMethods),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 170.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.account_box, size: 200.0, color: Colors.primaries[Random().nextInt(Colors.primaries.length)]),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Username', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                    Text(userName, style: TextStyle(fontSize: 17.0), maxLines: 1),
                  ],
                ),

                Divider(height: 20.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Email', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Text(_email, style: TextStyle(fontSize: 17.0), maxLines: 1),
                        SizedBox(width: 10.0),
                        GestureDetector(
                          onTap: () {
                            _editEmail(context);
                          },
                          child: Icon(Icons.edit, size: 20, color: Colors.black),
                        ),
                      ],
                    )
                    //Text(_email, style: TextStyle(fontSize: 17.0)),
                  ],
                ),

                Divider(height: 20.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Interests', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) { return Interests(userName: userName,);},),);
                      },
                      child: Text('see more', style: TextStyle(decoration: TextDecoration.underline,),),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  void _editEmail(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget changeButton = FlatButton(
      child: Text("Change"),
      onPressed: () async {
        _checkEmail(_newEmail);

        bool validated = false;

        if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_newEmail) && !_emailTaken) validated = true;

        if(validated) {
          await HelperFunctions.getUserNameSharedPreference().then((val) {
            DatabaseMethods(uid: _user.uid).updateEmail(_newEmail);
          });
          await HelperFunctions.saveUserEmailSharedPreference(_newEmail);
          _getInfo();
          Navigator.of(context).pop();
        }
      },
    );

    AlertDialog alertEmail = AlertDialog(
      title: Text("Change Email"),
      content:
      TextField(
          decoration: inputDeco("new email"),
          onChanged: (val) {
            _newEmail = val;
          },
          style: TextStyle(
              fontSize: 15.0,
              height: 2.0,
              color: Colors.black
          )
      ),
      actions: [
        cancelButton,
        changeButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertEmail;
      },
    );
  }

}