import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/auth.dart';
import 'package:proj_src/BackEnd/database.dart';
import 'package:proj_src/BackEnd/helper.dart';
import 'package:proj_src/Screens/Nav/Components/appBar.dart';
import 'package:proj_src/constants.dart';
import 'package:proj_src/BackEnd/AuxUser.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  AuthMethods _authMethods = new AuthMethods();
  String userName;
  String email;
  //List<String> interest = [];
  String interest = "interest list";
  Stream<QuerySnapshot> _users;
  List<AuxUser> _auxUsers = [];

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
        email = value;
      });
    });
    await DatabaseMethods().getUsers().then((val) {
      setState(() {
        _users = val;
      });
    });
    _parseStream(_users);
  }

  void _parseStream(Stream<QuerySnapshot> stream) async {
    await for (var snapshot in stream) {
      //AuxUser newUser = new AuxUser(snapshot.data.documents[index].id, snapshot.data.documents[index]['username'], snapshot.data.documents[index]['email']);
      //_auxUsers.add(newUser);
      /* _auxEmails.add(snapshot.data.documents[index]['email']);
              _auxUserNames.add(snapshot.data.documents[index]['username']);
              _auxEmails = _auxEmails.toSet().toList();*/
    }
    _auxUsers = _auxUsers.toSet().toList();
  }

  Widget _loadInfo() {
    return StreamBuilder(
        stream: _users,
        builder: (context, snapshot) {
          return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              AuxUser newUser = new AuxUser(snapshot.data.documents[index].id, snapshot.data.documents[index]['username'], snapshot.data.documents[index]['email']);
              _auxUsers.add(newUser);
             /* _auxEmails.add(snapshot.data.documents[index]['email']);
              _auxUserNames.add(snapshot.data.documents[index]['username']);
              _auxEmails = _auxEmails.toSet().toList();*/
              _auxUsers = _auxUsers.toSet().toList();
              print(_auxUsers);
              return null;
            },
            scrollDirection: Axis.vertical,
          )
              :
          null;
        }
    );
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
                    Text('Username', style: TextStyle(fontSize: 17.0)),
                    Text(userName, style: TextStyle(fontSize: 17.0)),
                  ],
                ),
                Divider(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Email', style: TextStyle(fontSize: 17.0)),
                    Text(email, style: TextStyle(fontSize: 17.0)),
                  ],
                ),
                Divider(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Interests', style: TextStyle(fontSize: 17.0)),
                    Text(interest, style: TextStyle(fontSize: 17.0)),
                  ],
                ),
                //Divider(height: 20.0,),
              ],
            ),
          )
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