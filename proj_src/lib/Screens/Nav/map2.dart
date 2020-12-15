import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/database.dart';
import 'package:proj_src/BackEnd/helper.dart';
import 'package:proj_src/Screens/Initials/initial_aux.dart';
import 'package:proj_src/Screens/Nav/Components/appBar.dart';
import 'package:proj_src/constants.dart';
import 'package:proj_src/Screens/Nav/Components/chatTile.dart';
import 'package:proj_src/Screens/Nav/networking.dart';

class Map2 extends StatefulWidget {
  @override
  _Map2State createState() => _Map2State();
}

class _Map2State extends State<Map2> {

  QuerySnapshot searchSnapshot;
  Stream<QuerySnapshot> _groups;
  User _user = FirebaseAuth.instance.currentUser;
  String _userName = '';
  String _email = '';
  String _newChatName = "";
  List<String> _auxChatNames = [];

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
    await DatabaseMethods().getActiveChats2().then((val) {
      setState(() {
        _groups = val;
      });
    });
    await HelperFunctions.getUserEmailSharedPreference().then((value) {
      setState(() {
        _email = value;
      });
    });
  }

  Widget _listChats() {
    return StreamBuilder(
        stream: _groups,
        builder: (context, snapshot) {
          return snapshot.hasData ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: (snapshot.data.documents.length <= 15) ? 0 : (snapshot.data.documents.length - 15),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              _auxChatNames.add(snapshot.data.documents[index]['name']);
              _auxChatNames = _auxChatNames.toSet().toList();
              return ChatTile(
                  userName: _userName,
                  groupId: snapshot.data.documents[index].id,
                  groupName: snapshot.data.documents[index]['name']
              );
            },
            scrollDirection: Axis.vertical,
          )
              :
          Container();
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar_Map(context),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/map2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            //Right_Arrow_Button(),
            _listChats(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    _addChat(context);
                  },
                  child: Icon(Icons.add, color: Colors.white, size: 30.0,),
                  backgroundColor: kPrimaryColor,
                  elevation: 0.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) { return NetworkingPage(userName: _userName,);},),);
                  },
                  child: Icon(Icons.person_add, color: Colors.white, size: 30.0,),
                  backgroundColor: kPrimaryColor,
                  elevation: 0.0,
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  void _addChat(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget createButton = FlatButton(
      child: Text("Create"),
      onPressed: () async {
        if (_auxChatNames.contains(_newChatName) || _auxChatNames.length >= 30 ) {
          Navigator.of(context).pop();
        }
        else if (_newChatName != null) {
          await HelperFunctions.getUserNameSharedPreference().then((val) {
            DatabaseMethods(uid: _user.uid).createChatRoom(val, _newChatName);
          });
          Navigator.of(context).pop();
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Don't see the topic you want?\n     Create a new chatroom!"),
      content: TextField(
          decoration: inputDeco("new topic"),
          onChanged: (val) {
            _newChatName = val;
          },
          style: TextStyle(
              fontSize: 15.0,
              height: 2.0,
              color: Colors.black
          )
      ),
      actions: [
        cancelButton,
        createButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
