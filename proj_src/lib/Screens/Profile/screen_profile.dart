import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/auth.dart';
import 'package:proj_src/BackEnd/database.dart';
import 'package:proj_src/BackEnd/helper.dart';
import 'package:proj_src/Screens/Initials/initial_aux.dart';
import 'package:proj_src/Screens/Nav/Components/appBar.dart';
import 'package:proj_src/constants.dart';
import 'package:proj_src/BackEnd/AuxUser.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  AuthMethods _authMethods = new AuthMethods();
  User _user = FirebaseAuth.instance.currentUser;
  String _userName;
  String _email;
  List<String> _interests = [];
  String _interestsString = '';
  QuerySnapshot _userQS;
  String _newInterest = "";

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  _getInfo() async {
    await HelperFunctions.getUserNameSharedPreference().then((value) {
      setState(() {
        _userName = value;
      });
    });
    await HelperFunctions.getUserEmailSharedPreference().then((value) {
      setState(() {
        _email = value;
      });
    });
    await DatabaseMethods().getUser(_userName).then((value) {
      setState(() {
        _userQS = value;
      });
    });
    _interests.clear();
    for(var i = 0; i< _userQS.docs[0].get('interests').length; i++) {
      _interests.add(_userQS.docs[0].get('interests')[i]);
    }
    _interests.forEach((element) {element.toLowerCase();});
    _interestsString = _interests.join(" / ");

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
               // _loadInfo(),
                Icon(Icons.account_circle, size: 200.0, color: Colors.grey[700]),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Username', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                    Text(_userName, style: TextStyle(fontSize: 17.0)),
                  ],
                ),
                Divider(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Email', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                    Text(_email, style: TextStyle(fontSize: 17.0)),
                  ],
                ),
                Divider(height: 20.0),
               //_listInterests(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Interests', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),),
                    GestureDetector(
                      onTap: (){
                        _seeInterests(context);
                      },
                      child: Text('see interests', style: TextStyle(fontSize: 17.0, decoration: TextDecoration.underline,),),
                    )
                  ],
                ),
                //Divider(height: 20.0,),
              ],
            ),
          )
      ),
    );
  }

  void _seeInterests(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget addButton = FlatButton(
      child: Text("Add"),
      onPressed:  () async {
        if(_interests.contains(_newInterest.toLowerCase())) {
          Navigator.of(context).pop();
        }
        else if (_newInterest != null){
          await HelperFunctions.getUserNameSharedPreference().then((val) {
            DatabaseMethods(uid: _user.uid).addInterest(_newInterest);
          });
          _getInfo();
          Navigator.of(context).pop();
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Interests"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _interests.isEmpty ?
          Text('You don\'t have any interests yet... add some!')
              : Text(_interestsString),
          TextField(
              decoration: inputDeco("new interest"),
              onChanged: (val) {
                _newInterest = val;
              },
              style: TextStyle(
                  fontSize: 15.0,
                  height: 2.0,
                  color: Colors.black
              )
          ),
        ],
      ),
      actions: [
        cancelButton,
        addButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }




  Widget _listInterests(){
    return ListView.builder(
      itemCount: _interests.length,
      itemBuilder: (context, index){
   /*     return Container(
            padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              color: k2PrimaryColor,
            ),
            child: Text(_interests[index], textAlign: TextAlign.start, style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: -0.5)),
        );*/
        return Text(_interests[index], style: TextStyle(fontSize: 17.0),);
      },
      scrollDirection: Axis.horizontal,
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