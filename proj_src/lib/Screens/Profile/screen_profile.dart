import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/auth.dart';
import 'package:proj_src/BackEnd/database.dart';
import 'package:proj_src/BackEnd/helper.dart';
import 'package:proj_src/Screens/Initials/welcome.dart';
import 'package:proj_src/Screens/Nav/Components/appBar.dart';
import 'package:proj_src/Screens/Nav/map1.dart';
import 'package:proj_src/Screens/Profile/interests.dart';
import 'package:proj_src/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final AuthMethods _authMethods = new AuthMethods();
  User _user = FirebaseAuth.instance.currentUser;
  String userName = '';
  String _email = '';
  List<String> _interests = [];
  String _interestsString = '';
  QuerySnapshot _userQS;
  String _newInterest = "";

  @override
  void initState() {
    super.initState();
    _getInfo();
    _getInterests();
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
  _getInterests() async {
    await DatabaseMethods().getUser(userName).then((value) {
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
                Icon(Icons.account_circle, size: 200.0, color: Colors.grey[700]),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Username', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                    Text(userName, style: TextStyle(fontSize: 17.0)),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Interest', style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) { return Interests(userName: userName,);},),);
                      },
                      child: Text('see more', style: TextStyle(decoration: TextDecoration.underline,),),
                    ),
                    //Text(_email, style: TextStyle(fontSize: 17.0)),
                  ],
                ),
              ],
            ),
          )
      ),
      /*body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: Stack(
            children: <Widget> [
              //_interestsList(),
            ],
          )
      ),*/
    );
  }

  Widget _interestsList() {
    return ListView.builder(
      itemCount: (_interests.length + 4),//snapshot.data.documents.length,
      itemBuilder: (context, index){
        if(index == 0) {
          return Text(
            'Interests',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          );
        }
        else if(index == 1) { return Divider(height: 30,); }
        else if(index == 2) {
          return
            TextField(
              decoration: InputDecoration(
                hintText: 'add a new interest!',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add_circle_outline_sharp, color: k2PrimaryColor, size: 25,),
                  padding: EdgeInsets.only(right: 5),
                  onPressed: () async {
                    if(!_interests.contains(_newInterest.toLowerCase()) && _newInterest != null && _newInterest != "") {
                      await HelperFunctions.getUserNameSharedPreference().then((val) {
                        DatabaseMethods(uid: _user.uid).addInterest(_newInterest);
                        _getInterests();
                      });
                    }
                  },
                ),
                border: OutlineInputBorder( borderRadius: BorderRadius.all( Radius.circular(5.0),),),
              ),
              onChanged: (val) async {
                _newInterest = val;
              },
            );
        }
        else if(index == 3) { return Divider(height: 30,); }
        else {
          return _interestTile(_interests[index-4]);
        }
      },
      scrollDirection: Axis.vertical,
    );
  }
  Widget _interestTile(String message) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                k2PrimaryColor,
                kPrimaryColor,
              ]
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child:
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(message, style: TextStyle(fontSize: 17.0, color: Colors.white)),
              GestureDetector(
                onTap: () async {
                  await HelperFunctions.getUserNameSharedPreference().then((val) {
                    DatabaseMethods(uid: _user.uid).removeInterest(message);
                    _getInterests();
                  });
                },
                child: Icon(Icons.remove_circle_outline_rounded, color: Colors.white, size: 25,),
              )
            ],
          ),
        ),
      ),
    );
  }

}